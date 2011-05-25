class CreateSugestoes < ActiveRecord::Migration
  def self.up
    create_table :sugestoes do |t|
      t.integer :usuario_id
      t.string :titulo
      t.text :texto
      t.integer :status
      t.date :dtenvio
      t.date :dtaceito
      t.date :dtpublicado
      t.date :dtpromovido

      t.timestamps
    end
  end

  def self.down
    drop_table :sugestoes
  end
end
