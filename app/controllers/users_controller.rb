class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def index
		@users=User.all
	end

	def new

	end

	def edit
		@user=User.find( params[:id])
	end

	def update
		@user=User.find( params[:id] )
		@user.update( user_params )
		redirect_to "/users/#{@user.id}"
	end

	def create
  		@user = User.new( user_params )
  		if @user.valid?
  			@user.save
	  		redirect_to "/users/#{@user.id}"
	  	else
	  		flash[:errors]=@user.errors.full_messages
	  		redirect_to :back
	  	end
	end

	def show
		if not params[:id]
			redirect_to "users/new"
		else
		@user = User.find(params[:id])
		@secrets = User.find(params[:id]).secrets.all		
		end
	end

	def destroy
		@user=User.find( params[:id] )
		@user.delete
		session.clear
		redirect_to "/sessions/new"
	end

	private 
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
	
end

