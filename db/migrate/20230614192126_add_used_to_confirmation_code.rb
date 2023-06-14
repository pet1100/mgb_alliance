class AddUsedToConfirmationCode < ActiveRecord::Migration[7.0]
  def change
    add_column :confirmations, :used, :boolean, default: false
  end
end
