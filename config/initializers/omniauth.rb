Rails.application.config.middleware.use OmniAuth::Builder do
  
#  provider :facebook, 'APP_ID', 'APP_SECRET'
#  provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
#  provider :github, 'CLIENT ID', 'SECRET'
  
  provider :facebook, '87847536708a7aed383af8621b4c5795', '7163bee61790b7d40b164ce3052560b3'
  provider :twitter, 'gy0dN7zazbhByotPXjcahw', 'EyjDj3d1NvmdxseKMCstOqIO81Q68DvMmLaqgV7J0'
  
  # Google (OpenID em geral) precisa de uma armazenamento persistente. Podemos usar ActiveRecord store ou a Filesystem store como abaixo. 
  # Para deploy no Heroku não temos permissão de escrita no /tmp, mas temos essa permissão de escrita no ./tmp
#  provider :openid, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  
end