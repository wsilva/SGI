# coding: utf-8
class ServicesController < ApplicationController
  
  before_filter :authenticate_usuario!, :except => [:create]
  
  def index
    # pega todos os serviços de autenticação do atual usuário
    @services = current_usuario.services.all    
  end
  
  def destroy
    
    # remove um serviço de autenticação linkado ao usuário atual
    @service = current_usuario.services.find(params[:id])
    @service.destroy
  
    redirect_to services_path
  end
  
  def create
    
    
    # pega o serviço no parametro do Rails Router
    params[:provider] ? service_route = params[:provider] : service_route = 'nenhum serviço (callback inválido)'
    
    # pega o hash do omniauth
    omniauth = request.env['omniauth.auth']
    
    # continua somente se hash e o parametro existir
    if omniauth and params[:provider]
      
      # mapeia o hash retornado para nossas variáveis o hash é deiferente para cada serviço
      
      # facebook
      if service_route == 'facebook'        
        omniauth['extra']['user_hash']['email'] ? email =  omniauth['extra']['user_hash']['email'] : email = ''
        omniauth['extra']['user_hash']['name'] ? name =  omniauth['extra']['user_hash']['name'] : name = ''
        omniauth['extra']['user_hash']['id'] ?  uid =  omniauth['extra']['user_hash']['id'] : uid = ''
        omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
        
      # twitter
      elsif service_route == 'twitter'
        email = ''    # O twitter não retorna o e-mail
        omniauth['user_info']['name'] ? name =  omniauth['user_info']['name'] : name = ''
        omniauth['uid'] ?  uid =  omniauth['uid'] : uid = ''
        omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
        
      # google  
      elsif service_route == 'google'
        omniauth['user_info']['email'] ? email =  omniauth['user_info']['email'] : email = ''
        omniauth['user_info']['name'] ? name =  omniauth['user_info']['name'] : name = ''
        omniauth['uid'] ? uid =  omniauth['uid'] : uid = ''
        omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
        
      else
        # outros serviços não reconhecidos        
        render :text => omniauth.to_yaml
        #render :text => uid.to_s + " - " + nome + " - " + email + " - " + provider
        return
      end
      
      
      
      # continuando somente se o service provider e o uid existirem
      if uid != '' and provider != ''
        
        # ninguém pode entrar duas vezes, ninguém pode se inscrever enquanto logado
        if !usuario_signed_in?
        
          # verificando se o usuário já autenticou usando este service provider e continua com o processo em caso afirmativo
          auth = Service.find_by_provider_and_uid(provider, uid)
          if auth
            flash[:notice] = 'Autenticado com sucesso via ' + provider.capitalize + '.'
            sign_in_and_redirect(:usuario, auth.usuario)
          else
            
            # verificando se este usuário já está registrado com esse endereço de email; saindo, se não foi fornecido e-mail
            if email != ''
              
              # procurando usuário com o e-mail retornado
              existingusuario = Usuario.find_by_email(email)
              
              if existingusuario
                
                # mapeando este novo método de login através de um service provider para uma conta existente se o endereço de email for o mesmo
                existingusuario.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
                flash[:notice] = 'Autenticação via ' + provider.capitalize + ' foi adicionada à sua conta ' + existingusuario.email + '. Autenticado com sucesso!'
                sign_in_and_redirect(:usuario, existingusuario)
                
              else
                # criando um novo usuário - registrar o usuário e adicionar esse método de autenticação para este usuário
                name = name[0, 199] if name.length > 199             # para passar pela validação de usuário

                # novo usuario, definimos o e-mail e uma senha aleatória e pegamos o nome do service provider
                usuario = Usuario.new :email => email, :password => SecureRandom.hex(10), :nome => name

                # adicionando o serviço de autenticação ao novo usuário
                usuario.services.build(:provider => provider, :uid => uid, :uname => name, :uemail => email)

                # não enviamos e-mail de confirmação, gravamos e confirmamos diretamente a conta criada
                # usuario.skip_confirmation! # não estamos usando confirmation
                usuario.save!
                # usuario.confirm! # não estamos usando confirmation

                # enviando a mensagem e autenticando
                flash[:myinfo] = 'Sua conta no SGI foi criada via ' + provider.capitalize + '. No seu perfil você pode alterar suas informações e sua senha local.'
                sign_in_and_redirect(:usuario, usuario)
                
              end
              
            else
              
              flash[:error] =  service_route.capitalize + ' não pode ser usado para autenticar no SGI. O e-mail para autenticação não foi fornecido. Por favor utilize outro serviço para autenticação ou faça um cadastro local. Se já possui um cadastro local utilize-o para entrar e adicione ' + service_route.capitalize + ' pelo seu perfil.'
              redirect_to new_usuario_session_path
              
            end
            
          end
          
        else
          
          # o usuario está autenticado
        
          # verificando se este serviço já está linkado à sua conta, se não, adicionamos
          auth = Service.find_by_provider_and_uid(provider, uid)
          
          if !auth            
            current_usuario.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
            flash[:notice] = 'Autenticação via ' + provider.capitalize + ' foi adicionada à sua conta.'
            redirect_to services_path
          else
            flash[:notice] = service_route.capitalize + ' já está linkada à sua conta.'
            redirect_to services_path
          end
          
        end
        
      else
        flash[:error] =  service_route.capitalize + ' retornou datos inválidos para sua idenificação de usuário.'
        redirect_to new_usuario_session_path
      end
      
    else
      flash[:error] = 'Erro ao autenticar via ' + service_route.capitalize + '.'
      redirect_to new_usuario_session_path
    end
      
  end
  
end