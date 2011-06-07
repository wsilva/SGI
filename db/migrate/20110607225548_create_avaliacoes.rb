class CreateAvaliacoes < ActiveRecord::Migration
  def self.up
    create_table :avaliacoes do |t|
      t.integer :usuario_id, :null => false         # foreign key
      t.integer :sugestao_id, :null => false        # foreign key
      t.integer :pontos

      t.timestamps
    end
    
    add_index :avaliacoes, :sugestao_id
  end

  def self.down
    drop_table :avaliacoes
  end
end
