module ApplicationHelper
  def gravatar(email, size) 
    gravatar_id = Digest::MD5::hexdigest(email).downcase 
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm" 
  end
  
  protected
  def is_admin
    if current_usuario
      if current_usuario.id == 1
        return 1
      end
    end
    redirect_to root_url
  end
end
