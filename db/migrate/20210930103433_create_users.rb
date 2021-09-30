class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :FIRST_NAME
      t.string :LAST_NAME
      t.string :EMAIL_ID

      t.timestamps
    end
  end
end
