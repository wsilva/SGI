class CreateSugestoes < ActiveRecord::Migration
  def self.up
    create_table :sugestoes do |t|
      t.integer :usuario_id, :null => false             # foreign key
      t.string :titulo, :null => false
      t.text :texto, :null => false
      t.integer :status, :null => false, :default => 0  # 0...rascunho, 1...enviado, 2...rejeitado, 3...publicado, 4...promovido
      t.string :motivo_rejeicao                         # mensagem para o autor ao rejeitar
      t.integer :visitas, :null => false, :default => 0
      t.integer :positivos, :null => false, :default => 0
      t.integer :negativos, :null => false, :default => 0
      t.date :dtpublicado
      t.date :dtpromovido

      t.timestamps
    end    
    add_index :sugestoes, :usuario_id
    
  end

  def self.down
    drop_table :sugestoes
  end
end
