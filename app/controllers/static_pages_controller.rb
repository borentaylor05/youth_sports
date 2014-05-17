class StaticPagesController < ApplicationController
  def home
  	@c = current_user.parent_comments.build if signed_in?
  end

  def help
  end

  def contact
  end

  def about
  	
  end
end
