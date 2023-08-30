class AddIndexToCodeAndConfirmedById < ActiveRecord::Migration[7.0]
  def change
    add_index :confirmations, :code
    add_index :confirmations, :confirmed_by
    add_index :confirmations, :confirmed_for
  end
end
