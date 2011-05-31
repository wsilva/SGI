class CreateIdeias < ActiveRecord::Migration
  def self.up
    create_table :ideias do |t|
        t.integer :usuario_id, :null => false           # foreign key
      t.string :titulo, :null => false
      t.text :texto, :null => false
      t.integer :status, :null => false, :default => 0  # 0...rascunho, 1...enviado, 2...rejeitado, 3...aceito/publicado, 4...promovido
      t.string :motivo_rejeicao                         # message to author on reject
      t.integer :visitas
      t.integer :positivos
      t.integer :negativos
      t.date :dtpublicacao
      t.date :dtrejeicao
      t.date :dtpromocao

      t.timestamps
    end
    
    add_index :ideias, :usuario_id
  end

  def self.down
    drop_table :ideias
  end
end
