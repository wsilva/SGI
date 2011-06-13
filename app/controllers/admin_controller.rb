# coding: utf-8
class AdminController < ApplicationController
  before_filter :authenticate_usuario!
  before_filter :is_admin
  
  def index
    @num_status0 = Ideia.where(:status => '0').count
    @num_status1 = Ideia.where(:status => '1').count
    @num_status2 = Ideia.where(:status => '2').count
    @num_status3 = Ideia.where(:status => '3').count
    @num_status4 = Ideia.where(:status => '4').count
    @num_published = @num_status3 + @num_status4
  
    @num_usuarios = Usuario.all.count
    @num_usuarios_active30days = Usuario.where('last_sign_in_at > ?', 30.days.ago).count
    @num_usuarios_created30days = Usuario.where('created_at > ?', 30.days.ago).count
  end

  def ideias
    if params[:status]    
      @status = params[:status]
      # invalid parameter? show submitted ideias
      if !['0', '1', '2', '3', '4'].index(@status)
        @status = '1'
      end
    else
      # no parameter? show submitted ideias
      @status = '1'
    end  

    # different sort order for different statuss; verbose the status for the view
    case @status
      when '0' then @status_name = 'rascunho'; @order = 'updated_at desc'
      when '1' then @status_name = 'enviada'; @order = 'updated_at desc'
      when '2' then @status_name = 'rejeitada'; @order = 'dtrejeicao desc'
      when '3' then @status_name = 'publicada'; @order = 'dtpublicacao desc'
      when '4' then @status_name = 'promivida'; @order = 'dtpromocao desc'
    end
  
    @ideias = Ideia.where(:status => @status).order(@order)      
  end
  
  # accept an ideia as normal or featured ideia
  def accept
    @ideia = Ideia.find(params[:id])

    # only submitted ideias can be accepted
    if @ideia.status == 1
      @ideia.status = 3
      flash[:notice] = 'A ideia foi publicada.'
    
      if params[:value]
        if params[:value] == '1'
          @ideia.status = 4
          flash[:notice] = 'A ideia foi promovida.'
        end  
      end  

      # freeeze
#      @ideia.freezebody = @ideia.title + "\n\n" + @ideia.teaser + "\n\n" + @ideia.body + "\n\n" + @ideia.version + "\n\n" + @ideia.changelog
      @ideia.dtpublicacao = Time.now 

      # save ideia
      if !@ideia.save
        flash[:notice] = 'Erro ao publicar ideia.'
      end
    else
      flash[:notice] = 'Somente ideias enviadas podem ser publicadas.'
    end

    redirect_to :action => 'ideias', :status => 1
  end
  
  # display form to enter reject message
  def editreject
    @ideia = Ideia.find(params[:id])
    # only submitted ideias can be rejected
    if @ideia.status != 1
      flash[:notice] = 'Somente ideias enviadas podem ser rejeitadas.'
      redirect_to :action => 'ideias', :status => 1 
    end
  end

  # reject the ideia (updates the ideia)
  def reject
    @ideia = Ideia.find(params[:id])

    if @ideia.status == 1
      if params[:ideia][:motivo_rejeicao]
        @ideia.status = 2
        @ideia.motivo_rejeicao = params[:ideia][:motivo_rejeicao] 
        @ideia.dtrejeicao = Time.now
#        @ideia.freezebody = @ideia.title + "\n\n" + @ideia.teaser + "\n\n" + @ideia.body + "\n\n" + @ideia.version + "\n\n" + @ideia.changelog
  
        if @ideia.save
          flash[:notice] = "A ideia foi rejeitada."
          redirect_to :action => 'ideias', :status => 1
        else
          render :action => "editreject"
        end  
      else
        flash[:notice] = "Não existe rejeição sem um motivo."
        redirect_to :action => 'ideias', :status => 1
      end
    else
      flash[:notice] = "Somente ideias enviadas podem ser rejeitadas."
      redirect_to :action => 'ideias', :status => 1
    end  
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
