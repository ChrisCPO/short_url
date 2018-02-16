class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :route, default: "", allow_nil: false
      t.string :path, default: "", allow_nil: false

      t.timestamps
    end

    add_index :urls, :path, using: :btree
  end
end
