class Contact < ApplicationRecord
  require 'csv'

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
