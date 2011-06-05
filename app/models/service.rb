class Service < ActiveRecord::Base
  belongs_to :usuario
  attr_accessible :provider, :uid, :uname, :uemail
end
