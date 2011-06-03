# coding: utf-8
class SugestoesController < ApplicationController
  before_filter :authenticate_usuario!

  # create a sugestao and bind it to an ideia and a usuario  
  def create
    @ideia = Ideia.find(params[:ideia_id])
    @sugestao = @ideia.sugestoes.build(params[:sugestao])
    @sugestao.usuario = current_usuario

    respond_to do |format|
      if @ideia.status > 2
        if @sugestao.save
          format.html { redirect_to(@ideia, :notice => 'Sugestão enviada com sucesso.') }
        else
          format.html { redirect_to(@ideia, :notice => 'Houve um erro ao gravar sua sugestão (sugestão vazia ou sugestão com texto muito longo).') }
        end
      else
        format.html { redirect_to(@ideia, :notice => 'Sugestões são limitadas a ideias publicadas.') }
      end  
    end
  end
  
  # remove a sugestao
  def destroy
    @sugestao = current_usuario.sugestoes.find(params[:id])
    @ideia = Ideia.find(params[:ideia_id])
    @sugestao.destroy
    
    respond_to do |format|
      format.html { redirect_to @ideia }
    end
  end
end
