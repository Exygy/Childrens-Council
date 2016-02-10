class HomeController < ApplicationController
  def index
  end

  def wordpress_template
    render 'wordpress_template', layout: false
  end

  def apikey
    render json: {apikey: "3473cb361d1ec90513627fc6997a589a", merchantid: "MUM7863245786fdsf656df"}
  end
end
