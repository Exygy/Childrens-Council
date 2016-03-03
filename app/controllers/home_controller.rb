class HomeController < ApplicationController
  def index
    render 'index', layout: false
  end

  def wordpress_template
    render 'wordpress_template', layout: false
  end
end
