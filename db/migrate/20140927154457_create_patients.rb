class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :addresssStreet
      t.string :addresssCity
      t.string :addresssState
      t.string :addresssCountry
      t.string :addresssZipcode
      t.integer :insuranceCompany

      t.timestamps
    end
  end
end
