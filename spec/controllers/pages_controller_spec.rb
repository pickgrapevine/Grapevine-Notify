require 'spec_helper'

describe PagesController do
  render_views

  before(:each)do
    @base_title = "Grapevine - Manage Your Reviews"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the correct title" do
      get 'home'
      response.should have_selector("title", 
        :content => "#{@base_title} | Home")
    end
  end

  describe "GET 'sign_up'" do
    it "should be successful" do
      get 'sign_up'
      response.should be_success
    end

    it "should have the correct title" do
      get 'sign_up'
      response.should have_selector("title", 
        :content => "#{@base_title} | Sign Up")
    end
  end

  describe "GET 'faq'" do
    it "should be successful" do
      get 'faq'
      response.should be_success
    end

    it "should have the correct title" do
      get 'faq'
      response.should have_selector("title", 
        :content => "#{@base_title} | FAQ")
    end
  end

  describe "GET 'about_us'" do
    it "should be successful" do
      get 'about_us'
      response.should be_success
    end

    it "should have the correct title" do
      get 'about_us'
      response.should have_selector("title", 
        :content => "#{@base_title} | About Us")
    end
  end

  describe "GET 'blog'" do
    it "should be successful" do
      get 'blog'
      response.should be_success
    end

    it "should have the correct title" do
      get 'blog'
      response.should have_selector("title", 
        :content => "#{@base_title} | Blog")
    end
  end

  describe "GET 'contact_us'" do
    it "should be successful" do
      get 'contact_us'
      response.should be_success
    end

    it "should have the correct title" do
      get 'contact_us'
      response.should have_selector("title", 
        :content => "#{@base_title} | Contact Us")
    end
  end

end
