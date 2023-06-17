class ChangeColumnTypeInPhoto < ActiveRecord::Migration[6.0]
  def change
    change_column :photos, :caption, :text
  end
end
