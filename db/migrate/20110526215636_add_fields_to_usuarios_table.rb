class AddFieldsToUsuariosTable < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :username, :string
    add_column :usuarios, :nome, :string
    add_column :usuarios, :nascimento, :date
    add_column :usuarios, :site, :string
  end

  def self.down
    remove_column :usuarios, :username
    remove_column :usuarios, :nome
    remove_column :usuarios, :nascimento
    remove_column :usuarios, :site
  end
end
