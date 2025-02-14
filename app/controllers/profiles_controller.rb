# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  def show
    render json: { user: @current_user }
  end
end
