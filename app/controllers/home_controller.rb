class HomeController < ApplicationController
  def index
  end

  def wordpress_template
    render 'wordpress_template', layout: false
  end
end
