class CreateSugestoes < ActiveRecord::Migration
  def self.up
    create_table :sugestoes do |t|
      t.integer :usuario_id
      t.integer :ideia_id
      t.text :msg, :null =>false

      t.timestamps
    end
    
    add_index :sugestoes, [:usuario_id, :ideia_id]
  end

  def self.down
    drop_table :sugestoes
  end
end
