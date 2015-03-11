class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :country
      t.string :city
      t.string :sex
      t.string :horoscope
      t.string :career
      t.string :hometown
      t.date :birthday
      t.text :introduction
      t.text :hobbies
      t.integer :age

      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
