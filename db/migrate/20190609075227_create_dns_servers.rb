class CreateDnsServers < ActiveRecord::Migration[6.0]
  def change
    create_table :dns_servers do |t|
      t.string :ip, null: false

      t.timestamps
    end

    add_index :dns_servers, :ip, unique: true
  end
end
