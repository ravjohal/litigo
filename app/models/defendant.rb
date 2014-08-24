class Defendant < ActiveRecord::Base
	has_one :contact, as: :contactable, dependent: :destroy
  belongs_to :case

	accepts_nested_attributes_for :contact

  private
  def self.with_contact
    array = []
    Defendant.all.each { |d| unless d.contact.nil? then array << d end }
    array
  end
end
