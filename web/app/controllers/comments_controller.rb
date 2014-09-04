class CommentsController < ApplicationController
  #Todo esto se sacó de una pagina web

  #Creamos el comentario
  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    # Not implemented: check to see whether the user has permission to create a comment on this object
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    if @comment.save
      if @obj.instance_of?(PublicacionCarpool)
        print "Algo"
        #@comment.create_activity :create, owner: current_user, recipient: @obj.user_evento.user, parameters: {publicacion_carpool_id: @obj.id}
      end
      render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
    else
      render :js => "alert('Hubo un error al crear el comentario');"
    end
  end

  #Borramos el comentario
  def destroy
  @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('Hubo un error al borrar el comentario');"
    end
  end
end