class UpdateUnreadDefaultToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :unread, from: nil, to: '0'
  end
end
