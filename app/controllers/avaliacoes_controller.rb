# coding: utf-8
class AvaliacoesController < ApplicationController
  before_filter :authenticate_usuario!
  
  # criando a avaliação
  def create
    @sugestao = Sugestao.find(params[:sugestao_id])
    @avaliacao = @sugestao.avaliacoes.build(params[:avaliacao])
    @avaliacao.usuario = current_usuario
    
    respond_to do |format|
      if @avaliacao.save
        format.html { redirect_to(@sugestao, :notice => 'Obrigado por avaliar essa sugestão!') }
      else
        format.html { redirect_to(@sugestao, :notice => 'Erro ao gravar sua avaliação.') }
      end
    end    
  end

  # atualizando uma avaliação
  def update
    @avaliacao = current_usuario.avaliacoes.find(params[:id])
    @sugestao = Sugestao.find(params[:sugestao_id])

    respond_to do |format|
      if @avaliacao.update_attributes(params[:avaliacao])
        format.html { redirect_to(@sugestao, :notice => 'Obrigado por atualizar sua avaliação!') }
      else
        format.html { redirect_to(@sugestao, :notice => 'Erro ao gravar sua avaliação.') }
      end  
    end
  end

  # removendo uma avaliação
  def destroy
    @avaliacao = current_usuario.avaliacoes.find(params[:id])
    @sugestao = Sugestao.find(params[:sugestao_id])
    
    @avaliacao.destroy
    
    respond_to do |format|
      format.html { redirect_to @sugestao }
    end
  end
  
end
