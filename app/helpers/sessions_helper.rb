module SessionsHelper
  def current_user? user
    user == current_user
  end

  def check_admin
    unless current_user.is_admin?
      flash[:alert]= "user isn't admin!"
      redirect_to root_path
    end    
  end
end