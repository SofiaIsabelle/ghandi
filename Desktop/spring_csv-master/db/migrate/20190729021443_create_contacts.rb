class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :uid
      t.string :phone
      t.string :first
      t.string :last
      t.string :email
    end
  end
end


