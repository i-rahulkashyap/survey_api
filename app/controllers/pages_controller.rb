class PagesController < ApplicationController
  def test_sso
    redirect_to '/auth/google_oauth2'
  end
end
