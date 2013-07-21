class LobbiesController < ApplicationController
  def update
    @user = current_user || User.find(params[:user_id])  
    respond_to do |format|
      if @user.validate_invitation(params[:access_code]) 
        format.html { redirect_to root_path, notice: 'Service Provider selected successfully.' }
        format.json { head :no_content }
        format.js
      else
        format.html { 
          flash.now[:error] =  'Invalid access code.'
          render action: "show"      
        }
        format.json { render json: @user.errors, status: :invalid_invitation_code }
      end
    end
  end

  def show
    @user = current_user
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
