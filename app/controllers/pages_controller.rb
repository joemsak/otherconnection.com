class PagesController < ApplicationController
  rescue_from "ActiveRecord::RecordNotFound", with: :redirect_to_safe_landing

  def show
    @page = Page.friendly.find(params[:id])
  end
end
