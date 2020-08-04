class HomeController < ApplicationController
  def index
    if Rails.env.development?
      render 'index', layout: false
    else
      redirect_to 'http://www.childrenscouncil.org/families/find-child-care/child-care-referrals/child-care-search/'
    end
  end

  def provider_ids
    render json: NdsApiService.new.fetch_all_provider_ids, status: 200
  end

  def wordpress_template
    render 'wordpress_template', layout: false
  end
end
