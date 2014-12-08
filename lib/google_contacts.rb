class GoogleContacts
  require 'phone'
  class << self
    attr_reader :client

    def initialize(user)
      @client = init_client(user)
    end

    def execute(options = {})
      @client.execute({ headers: { 'GData-Version' => '3.0', 'Content-Type' => 'application/json' } }.merge(options))
    end

    def fetch_all(options = {})
      execute(uri: "https://www.google.com/m8/feeds/contacts/default/full",
              parameters: { 'alt' => 'json',
                            # 'updated-min' => options[:since] || '2011-03-16T00:00:00',
                            'max-results' => '100000' }).data
    end

    def contacts(user)
      @client = init_client(user)
      contacts = fetch_all['feed']['entry'].map do |contact|
        {
            emails: extract_schema(contact['gd$email']),
            phone_numbers: extract_schema(contact['gd$phoneNumber']),
            handles: extract_schema(contact['gd$im']),
            addresses: extract_schema(contact['gd$structuredPostalAddress']),
            name_data: cleanse_gdata(contact['gd$name']),
            nickname: contact['gContact$nickname'] && contact['gContact$nickname']['$t'],
            websites: extract_schema(contact['gContact$website']),
            organizations: extract_schema(contact['gd$organization']),
            events: extract_schema(contact['gContact$event']),
            birthday: contact['gContact$birthday'].try(:[], "when")
        }.tap do |basic_data|
          # Extract a few useful bits from the basic data
          basic_data[:full_name] = basic_data[:name_data].try(:[], :full_name)
          primary_email_data = basic_data[:emails].find { |type, email| email[:primary] }
          if primary_email_data
            basic_data[:primary_email] = primary_email_data.last[:address]
          end
        end
      end
      contacts.each do |contact|
        cont = Contact.where(user_id: user.id, email: contact[:primary_email]).first_or_initialize
        cont.user_id = user.id
        cont.contact_user_id = user.id
        cont.firm_id = user.firm_id
        cont.email = contact.try(:[], :primary_email)
        cont.first_name = contact[:name_data].try(:[], :given_name)
        cont.middle_name = contact[:name_data].try(:[], :additional_name)
        cont.last_name = contact[:name_data].try(:[], :family_name)
        if contact[:addresses].present?
          addr = contact[:addresses][contact[:addresses].keys.first]
          cont.address =  addr.try(:[], :formatted_address)
          cont.city =  addr.try(:[], :formatted_address)
          cont.city =  addr.try(:[], :city)
          cont.state =  addr.try(:[], :region)
          cont.country =  addr.try(:[], :country).try(:[], "code")
        end
        if contact[:phone_numbers].present?
          cont.phone_number = contact[:phone_numbers][contact[:phone_numbers].keys.first]
          cont.fax_number = contact[:phone_numbers].try(:[], :home_fax) || contact[:phone_numbers].try(:[], :work_fax)
        end

        cont.age = age(contact[:birthday]) if contact[:birthday].present?
        cont.date_of_birth = contact.try(:[], :birthday)
        cont.save!
        end
    end

    protected

    # Turn an array of hashes into a hash with keys based on the original hash's 'rel' values, flatten, and cleanse.
    def extract_schema(records)
      (records || []).inject({}) do |memo, record|
        key = (record['rel'] || 'unknown').split('#').last.to_sym
        value = cleanse_gdata(record.except('rel'))
        value[:primary] = true if value[:primary] == 'true' # cast to a boolean for primary entries
        value[:protocol] = value[:protocol].split('#').last if value[:protocol].present? # clean namespace from handle protocols
        value = value[:$t] if value[:$t].present? # flatten out entries with keys of '$t'
        value = value[:href] if value.is_a?(Hash) && value.keys == [:href] # flatten out entries with keys of 'href'
        memo[key] = value
        memo
      end
    end

    # Transform this
    #     {"gd$fullName"=>{"$t"=>"Bob Smith"},
    #      "gd$givenName"=>{"$t"=>"Bob"},
    #      "gd$familyName"=>{"$t"=>"Smith"}}
    # into this
    #     { :full_name => "Bob Smith",
    #       :given_name => "Bob",
    #       :family_name => "Smith" }
    def cleanse_gdata(hash)
      (hash || {}).inject({}) do |m, (k, v)|
        k = k.gsub(/\Agd\$/, '').underscore # remove leading 'gd$' on key names and switch to underscores
        v = v['$t'] if v.is_a?(Hash) && v.keys == ['$t'] # flatten out { '$t' => "value" } results
        m[k.to_sym] = v
        m
      end
    end

    private

    def init_client(user)
      client = Google::APIClient.new
      fresh_token(user)
      client.authorization.access_token = user.oauth_token
      client.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
      client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
      client.authorization.refresh_token = user.oauth_refresh_token
      return client
    end

    def request_token_from_google(user)
      url = URI("https://accounts.google.com/o/oauth2/token")
      Net::HTTP.post_form(url, {'refresh_token' => user.oauth_refresh_token,
                                'client_id' => ENV['GOOGLE_CLIENT_ID'],
                                'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
                                'grant_type' => 'refresh_token'})
    end

    def refresh!(user)
      response = request_token_from_google(user)
      data = JSON.parse(response.body)
      user.oauth_token = data['access_token']
      user.oauth_expires_at = Time.now + (data['expires_in'].to_i).seconds
      user.save!
    end

    def expired?(user)
      user.oauth_expires_at < Time.now
    end

    def fresh_token(user)
      refresh!(user) if expired?(user)
    end

    def age(date)
      now = Time.now.utc.to_date
      birthday = date.to_date
      now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    end
  end
end