module SessionsHelper
  def current_user? user
    user == current_user
  end

  def check_admin
    unless current_user.is_admin?
      flash[:alert]= t "user.not_admin"
      redirect_to root_path
    end
  end
end
