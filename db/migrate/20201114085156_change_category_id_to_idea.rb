class ChangeCategoryIdToIdea < ActiveRecord::Migration[6.0]
  def change
    change_column :ideas, :category_id, :bigint
  end
end
