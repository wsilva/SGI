# coding: utf-8
class SugestoesController < ApplicationController
  
  # only index and show are accessible for non-authenticated users
  before_filter :authenticate_usuario!, :except => [:index, :show]
  
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # GET /sugestoes
  # GET /sugestoes.xml
  def index
    @sugestoes = Sugestao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sugestoes }
    end
  end
  
  def minhassugestoes
    @minhassugestoes = current_usuario.sugestoes.all
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @minhassugestoes}
    end
  end
  
  def submit
    @minhasugestao = current_usuario.sugestoes.find(params[:id])
    
    # submit only, if article is currently in draft or rejected-status
    if (@minhasugestao.status == 0) or (@minhasugestao.status == 2)
      @minhasugestao.status = 1
      @minhasugestao.submitted = Time.now

      if @minhasugestao.save
        flash[:notice] = 'Sua ideia enviada para aprovação com sucesso.'
      else
        flash[:error] = 'Erro ao enviar a ideia.'   
      end           
    else
      flash[:error] = 'A ideia não pode ser enviada.'  
    end

    respond_to do |format|
      format.html { redirect_to(:action => 'minhassugestoes') }
      format.xml  { head :ok }
    end
  end

  # GET /sugestoes/1
  # GET /sugestoes/1.xml
  def show
    @sugestao = Sugestao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sugestao }
    end
  end

  # GET /sugestoes/new
  # GET /sugestoes/new.xml
  def new
    @sugestao = Sugestao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sugestao }
    end
  end

  # GET /sugestoes/1/edit
  def edit
    @sugestao = Sugestao.find(params[:id])
  end

  # POST /sugestoes
  # POST /sugestoes.xml
  def create
    @sugestao = Sugestao.new(params[:sugestao])
    @sugestao.usuario = current_usuario

    respond_to do |format|
      if @sugestao.save
        format.html { redirect_to(@sugestao, :notice => 'Nova ideia criada.') }
        format.xml  { render :xml => @sugestao, :status => :created, :location => @sugestao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sugestao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sugestoes/1
  # PUT /sugestoes/1.xml
  def update
#    @sugestao = Sugestao.find(params[:id])
    @sugestao = current_usuario.sugestoes.find(params[:id])
    
    if @sugestao.status > 2
      params[:sugestao].delete(:titulo)
    end

    respond_to do |format|
      if @sugestao.update_attributes(params[:sugestao])
        format.html { redirect_to(@sugestao, :notice => 'Ideia atualizada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sugestao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sugestoes/1
  # DELETE /sugestoes/1.xml
  def destroy
    @sugestao = current_usuario.sugestoes.find(params[:id])

    if (@sugestao.status < 3)
      @sugestao.destroy
    else
      flash[:error] = "A ideia não pode ser removida."
    end

    respond_to do |format|
      format.html { redirect_to(sugestoes_url) }
      format.xml  { head :ok }
    end
  end  
  
  protected
  
  def record_not_found
    flash[:error] = "Ops, a ideia que você esta tentando acessar não existe!"
    redirect_to root_url    
  end
  
end
