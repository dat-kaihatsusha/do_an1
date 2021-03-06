class UsersController < ApplicationController	
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]	
	before_action :find_user, only: [:show, :edit, :update, :destroy]	
	before_action :correct_user, only: [:edit, :update]	

	def index	
		@users = User.paginate(page: params[:page])	
	end	

	def new	
		@user = User.new	
	end	

	def create	
		@user = User.new user_params	
		if @user.save	
			log_in @user	
			flash[:success] = "Welcome to the Sample App!"	
			redirect_to @user	
		else	
			render :new	
		end	
	end	

	def show	
	end

	def edit	
	end	

	def update	
		if @user.update user_params	
			flash[:success] = "Profile updated"	
			redirect_to @user	
		else	
			render :edit	
		end	
	end	

	private	
	def user_params	
		params.require(:user).permit :name, :email, :password,:password_confirmation	
	end	

	def find_user	
		@user =  User.find_by id: params[:id]	
		unless @user.present?	
			flash[:success] = "User doesn't exist"	
			redirect_to users_url	
		end	
	end	

	def correct_user	
		redirect_to root_url unless @user.current_user? current_user	
	end	

	def admin_user	
		redirect_to root_url unless current_user.admin?	
	end	

end 