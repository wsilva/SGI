class Sugestao < ActiveRecord::Base
    
  belongs_to :usuario
  belongs_to :ideia
  
  attr_accessible :msg
  
  validates :usuario_id, :presence => true
  validates :ideia_id, :presence => true
  validates :msg, :presence => true, :length => { :maximum => 50000 }     # spam protection

  default_scope :order => 'sugestoes.created_at asc'
  
end
