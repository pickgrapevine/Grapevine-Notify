class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def sign_up
    @title = "Sign Up"
  end

  def faq
    @title = "FAQ"
  end

  def about_us
    @title = "About Us"
  end

  def blog
    @title = "Blog"
  end

  def contact_us
    @title = "Contact Us"
  end

end
