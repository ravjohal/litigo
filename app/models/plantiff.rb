class Plantiff < ActiveRecord::Base
	has_one :contact, as: :contactable, dependent: :destroy
  belongs_to :case

	accepts_nested_attributes_for :contact

  private
  def self.with_contact
    array = []
    Plantiff.all.each { |p| unless p.contact.nil? then array << p end }
    array
  end
end
