class CreateUserAndUuidTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
        t.datetime :last_used
    end
    create_table :uuids do |t|
        t.string "value", limit: 64
        t.references :user, index: true, foreign_key: true
    end
  end
end
