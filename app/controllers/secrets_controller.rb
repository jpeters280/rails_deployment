class SecretsController < ApplicationController
	def new

	end
	def create
		if not session['id']
			redirect_to '/sessions/new'
		else
			@secret = User.find(secret_params[:user_id]).secrets.new( secret_params )
	  		if @secret.valid?
	  			@secret.save
		  		redirect_to "/users/#{secret_params[:user_id]}"
		  	else
		  		flash[:errors]=@secret.errors.full_messages
		  		redirect_to :back
		  	end
		end
	end

	def destroy
		if not session['id'] 
			redirect_to '/sessions/new'
		else
			if not session['id'] == params[:id]
				redirect_to "/users/#{session['id']}"
			else
			@secret=Secret.find( params[:id] )
			@secret.delete
			redirect_to "/users/#{session['id']}"
		end
		end
	end
	def index
		if not session[:id]
			redirect_to '/sessions/new'
		else
			@secrets = Secret.all
		end
	end
	
	private
	def secret_params
		params.require(:secret).permit(:content, :user_id)
	end
end
