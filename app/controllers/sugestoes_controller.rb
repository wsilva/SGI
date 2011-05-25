class SugestoesController < ApplicationController
  
  # only index and show are accessible for non-authenticated users
  before_filter :authenticate_usuario!, :except => [:index, :show]

  # GET /sugestoes
  # GET /sugestoes.xml
  def index
    @sugestoes = Sugestao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sugestoes }
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

    respond_to do |format|
      if @sugestao.save
        format.html { redirect_to(@sugestao, :notice => 'Sugestao was successfully created.') }
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
    @sugestao = Sugestao.find(params[:id])

    respond_to do |format|
      if @sugestao.update_attributes(params[:sugestao])
        format.html { redirect_to(@sugestao, :notice => 'Sugestao was successfully updated.') }
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
    @sugestao = Sugestao.find(params[:id])
    @sugestao.destroy

    respond_to do |format|
      format.html { redirect_to(sugestoes_url) }
      format.xml  { head :ok }
    end
  end
end
