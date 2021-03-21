class User::AuthenticationsController < ApplicationController
  def destroy
    authentication = current_user.authentications.find_by(provider: params[:id])
    authentication.destroy
    redirect_to user_dashboard_path
  end
end
