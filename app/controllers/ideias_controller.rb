# coding: utf-8
class IdeiasController < ApplicationController
  
  # only index and show are accessible for non-authenticated users
  before_filter :authenticate_usuario!, :except => [:index, :show, :about, :todas]
  
  #recovering
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  # GET /ideias
  # GET /ideias.xml
  def index
    #    @ideias = Ideia.all
    @ideias = Ideia.where(:status => '3')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideias }
    end
  end
  
  def minhasideias
    @minhasideias = current_usuario.ideias.all
 
    respond_to do |format|
      format.html
      format.xml  { render :xml => @minhasideias }
    end
  end

#  def todas
#    @ideia = Ideia.where(:status => ['3', '4'])  
#    if @ideia.size < 1
#      flash[:notice] = "Nenhuma ideia para listar com status 3 ou 4."
#      redirect_to root_url
#    else
#      respond_to do |format|
#        format.html { render 'index' } # uses the same view as the default index
#        format.xml  { render :xml => @ideia }
#      end
#    end
#  end
  
  # GET /ideias/1
  # GET /ideias/1.xml
  def show
    @ideia = Ideia.find(params[:id])
    
    # incrementando visitação
    @ideia.visitas = @ideia.visitas + 1
    @ideia.save
    @sugestoes = @ideia.sugestoes.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ideia }
    end
  end
  
  def submit
    @ideia = current_usuario.ideias.find(params[:id])

    # submit only, if ideia is currently in draft or rejected-state
    if (@ideia.status == 0) or (@ideia.status == 2)
      @ideia.status = 1

      if @ideia.save
        flash[:notice] = 'Sua ideia foi enviada para a moderação.'
      else
        flash[:error] = 'Houve um erro ao enviar sua ideia.'   
      end           
    else
      flash[:error] = 'Essa ideia não pode ser enviada.'  
    end

    respond_to do |format|
      format.html { redirect_to(:action => 'minhasideias') }
      format.xml  { head :ok }
    end
  end

  # GET /ideias/new
  # GET /ideias/new.xml
  def new
    #    @ideia = Ideia.new
    @ideia = current_usuario.ideias.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ideia }
    end
  end

  # GET /ideias/1/edit
  def edit
    #    @ideia = Ideia.find(params[:id])
    @ideia = current_usuario.ideias.find(params[:id])
  end  

  # POST /ideias
  # POST /ideias.xml
  def create
    #    @ideia = Ideia.new(params[:ideia])
    @ideia = current_usuario.ideias.new(params[:ideia])

    respond_to do |format|
      if @ideia.save
        format.html { redirect_to(@ideia, :notice => 'Ideia criada com sucesso.') }
        format.xml  { render :xml => @ideia, :status => :created, :location => @ideia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ideia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideias/1
  # PUT /ideias/1.xml
  def update
    #    @ideia = Ideia.find(params[:id])
    @ideia = current_usuario.ideias.find(params[:id])
    
    # if an ideia has already been accepted, the user is not allowed to change titulo
    if @ideia.status > 2
      params[:ideia].delete(:titulo)
    end

    respond_to do |format|
      if @ideia.update_attributes(params[:ideia])
        format.html { redirect_to(@ideia, :notice => 'Ideia alterada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ideia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideias/1
  # DELETE /ideias/1.xml
  def destroy
    #    @ideia = Ideia.find(params[:id])
    @ideia = current_usuario.ideias.find(params[:id])
    
    # only draft, submitted or rejected ideias can be deleted by the user
    if (@ideia.status < 3)
      @ideia.destroy
    else
      flash[:error] = 'Essa ideia não pode ser removida.'   
    end

    respond_to do |format|
      format.html { redirect_to(ideias_url) }
      format.xml  { head :ok }
    end
  end
  
  def about 
  end
  
  protected
  def record_not_found
    flash[:error] = 'A ideia que está tentando acessar não existe.'
    redirect_to root_url
  end
end
