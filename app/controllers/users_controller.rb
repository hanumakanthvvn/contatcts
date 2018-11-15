class UsersController < ApiController
	before_action :require_login, except: [:create]

  def create
  	user = User.new(user_params)
    if user.save
  	  render json: {token: user.auth_token}
    else
      puts "errors"
      render json: user.errors, status: 500
    end
  end

  def profile
  	user = User.find_by_auth_token!(request.headers[:token])
  	render json: {user: {username: user.username, email: user.email, firstname: user.first_name, lastname: user.last_name}}
  end 

  private
  def user_params
  	params.require(:user).permit(:username, :email, :password, :first_name, :last_name)
  end
end
