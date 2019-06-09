class CreateHostnames < ActiveRecord::Migration[6.0]
  def change
    create_table :hostnames do |t|
      t.string :domain, null: false
      t.references :dns_server, null: false, foreign_key: true

      t.timestamps
    end

    add_index :hostnames, :domain
    add_index :hostnames, [:dns_server_id, :domain], unique: true
  end
end
