class SessionsController < ApplicationController
  
  def new
  end

# The actual parameters hash created by form_for and form_tag have different
# internal structures. When using form_for, a nested hash is created inside
# the parameters hash. This hash contains :email, which is why you have to
# use the params[:session][:email] syntax. form_tag, on the other hand does
# not create a nested hash, so You can access the email field directly with
# params[:email]. – Josh Infiesto
  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
