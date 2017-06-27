class ContactsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper
  include DatesHelper

  def initialize(view, user, user_contacts)
    @view = view
    @user = user
    @firm = @user.firm
    @user_contacts = user_contacts
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: contacts.count(:all),
        iTotalDisplayRecords: contacts.count(:all),
        aaData: data
    }
  end

  private

  def data
    contacts.map do |one_contact|
      [
          one_contact.try(:name),
          link_to(one_contact.try(:type), one_contact),
          one_contact.email,
          one_contact.phone_number
      ]
    end
  end

  def contacts
    @contacts ||= fetch_contacts
  end

  def fetch_contacts
   
    contacts = @firm.contacts #.send(params[:contactsScope])
    puts " ALL Contacts " + params[:contactsScope].to_s

      

    if params[:iSortCol_0].to_i == 1
      contacts = contacts.order("name #{sort_direction}")
    elsif params[:iSortCol_0].to_i == 2
      contacts = contacts.order("type #{sort_direction}")
    elsif params[:iSortCol_0].to_i == 3
      contacts = contacts.order("email #{sort_direction}")      
    else
      contacts = contacts.order("#{sort_column} #{sort_direction}")
    end
    contacts = contacts.page(page).per_page(per_page)
    if params[:sSearch].present?
      contacts = contacts.search_contact(params[:sSearch])
    end
    contacts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[last_name type email phone_number]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end