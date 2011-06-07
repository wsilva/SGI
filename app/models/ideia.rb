class Ideia < ActiveRecord::Base
  belongs_to :usuario
  has_many :sugestoes, :dependent => :destroy
  
  attr_accessible :titulo, :texto, :status, :motivo_rejeicao, :visitas
  
  # 0...rascunho, 1...enviado, 2...rejeitado, 3...publicado, 4...promovido
  
  validates :usuario_id, :presence => true
  validates :titulo, :presence => true, :length => { :maximum => 180 }
  validates :texto, :presence => true, :length => { :maximum => 5000 }
  validates :status, :presence => true, :numericality => true, :inclusion => { :in => 0..4 }
  validates :motivo_rejeicao, :length => { :maximum => 5000 }
  
end
