class UsersController < ApplicationController
  def create
    @organization = Organization.find_by(name: 'elitmus.com') || Organization.find_by(name: 'gmail.com') || Organization.find_by(name: 'Default')

    if @organization.nil?
      render json: { error: 'Organization not found.' }, status: :not_found
    else
      @user = User.new(user_params.merge(organization: @organization))

      if @user.save
        render json: UserSerializer.new(@user).serializable_hash, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end