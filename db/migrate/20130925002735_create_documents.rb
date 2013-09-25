class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :doc
      t.text :content
      t.boolean :indexed, default: false

      t.timestamps
    end
  end
end
