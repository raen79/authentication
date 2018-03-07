class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :lecturer_id
      t.string :student_id
      t.string :password_digest

      t.timestamps
    end
  end
end
