class CreateUserAndUuidTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
        t.datetime :last_used
        t.string :uuid, limit: 64
        t.integer :rating, default: 0, null: false
    end
    create_table :confirmations do |t|
        t.string :code, limit: 128
        t.references :confirmed_for
        t.references :confirmed_by
    end

    add_foreign_key :confirmations, :users, column: :confirmed_for_id, primary_key: :id
    add_foreign_key :confirmations, :users, column: :confirmed_by_id, primary_key: :id
  end
end
