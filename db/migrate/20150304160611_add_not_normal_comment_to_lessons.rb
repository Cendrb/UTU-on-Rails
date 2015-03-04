class AddNotNormalCommentToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :not_normal_comment, :string
  end
end
