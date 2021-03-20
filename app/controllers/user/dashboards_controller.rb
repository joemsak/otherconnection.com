class User::DashboardsController < ApplicationController
  before_action :authenticate_user_registration!
end
