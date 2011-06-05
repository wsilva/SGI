class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :usuario_id
      t.string :provider
      t.string :uid
      t.string :uid
      t.string :uname
      t.string :uemail

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
