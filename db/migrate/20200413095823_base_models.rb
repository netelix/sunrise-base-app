class BaseModels < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :admin, :boolean, default: false

    create_table :things do |t|
      t.timestamps
      t.references :users
    end
  end
end
