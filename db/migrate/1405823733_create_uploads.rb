class CreateUploads < ActiveRecord::Migration
  def up
    create_table :uploads do |t|
      t.references :user
      t.string :filepath
    end
  end

  def down
    # add reverse migration code here
  end
end