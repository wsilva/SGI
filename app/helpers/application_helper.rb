module ApplicationHelper
  def gravatar(email, size) 
    gravatar_id = Digest::MD5::hexdigest(email).downcase 
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm" 
  end
end
