class AddPersonalFieldsToUsuariosTable < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :username, :string
    add_column :usuarios, :nome, :string
    add_column :usuarios, :dtnascimento, :date
    add_column :usuarios, :url, :string
  end

  def self.down
    remove_column :usuarios, :url
    remove_column :usuarios, :dtnascimento
    remove_column :usuarios, :nome
    remove_column :usuarios, :username
  end
end
