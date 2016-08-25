class SessionsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
	def new

	end
	def create
		 user = User.find_by_email(session_params[:email])

		if user && user.authenticate(session_params[:password])
	      session[:id] = user.id
	      redirect_to "/users/#{session['id']}"
		else
	      flash[:errors] = ["Invalid combination"]
	      redirect_to "/sessions/new"
	    end
	end

	def destroy
		session.clear
		redirect_to "/sessions/new"
	end
	private
	def session_params
		params.require(:user).permit(:email, :password)
	end
end
