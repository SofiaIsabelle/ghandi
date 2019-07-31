class Contact < ApplicationRecord
  require 'csv'

    validates :uid, presence: true, length: {minimum: 5, maximum: 5 }
    validates :phone, presence: true, length: {minimum: 10, maximum: 11}
    validates :first, presence: true, length: {minimum: 3, maximum: 55}
    validates :last, presence: true, length: {minimum: 2, maximum: 55}
    validates :email, presence: true, length: {minimum: 5, maximum: 320}

  def self.import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      contact_hash = row.to_hash
      contact = Contact.where(id: contact_hash["id"])

      if contact.count == 1
        # Prevent CSV updates from changing the database emails attribute
        contact.first.update_attributes(contact_hash.expect("email"))
      else
        Contact.create!(contact_hash)
      end
    end
  end

  def self.search(search)
    if search
      where('first LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

end

#pushing commit