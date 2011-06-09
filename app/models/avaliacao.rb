class Avaliacao < ActiveRecord::Base
  
  belongs_to :usuario
  belongs_to :sugestao
  
  attr_accessible :pontos
  
  validates :usuario_id, :presence => true
  validates :sugestao_id, :presence => true
  validates :pontos, :presence => true, :numericality => true, :inclusion => { :in => -1..1 }
  
end
