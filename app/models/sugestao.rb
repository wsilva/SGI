class Sugestao < ActiveRecord::Base
    
  belongs_to :usuario
  belongs_to :ideia
  has_many :avaliacoes, :dependent => :destroy
  
  attr_accessible :msg
  
  validates :usuario_id, :presence => true
  validates :ideia_id, :presence => true
  validates :msg, :presence => true, :length => { :maximum => 50000 }     # spam protection

  default_scope :order => 'sugestoes.created_at asc'
  
  # qtde de avaliações
  def conta_avaliacoes
    self.avaliacoes.all.count
  end
  
  # media de pontos da avaliação
  def media_pontos
    @media = self.avaliacoes.average(:pontos)     
    @media ? @media : 0
  end
  
end
