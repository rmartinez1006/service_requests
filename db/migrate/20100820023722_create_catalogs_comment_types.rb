class CreateCatalogsCommentTypes < ActiveRecord::Migration
  def self.up
    create_table :catalogs_comment_types do |t|
      t.string :abbr
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_comment_types
  end
end
