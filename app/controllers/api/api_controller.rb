module Api
  class ApiController < ApplicationController
    before_action :check_parent_credentials
    before_action :create_referral_log
    after_action :send_apikey

    private

    def check_parent_credentials
      @current_parent = find_or_create_parent if parent_params_valid?
      raise_not_authorized! unless @current_parent and @current_parent.persisted?
    end

    def create_referral_log
      ReferralLog.create(
        params: params,
        parent: @current_parent,
      )
    end

    def send_apikey
      response.headers['Cc-Apikey'] = @current_parent.api_key
    end

    def find_or_create_parent
      result = Parent.where(valid_parent_params).first_or_create do |record|
        available_attributes = Parent.new.attributes.keys & valid_parent_params.keys.map(&:to_s)
        available_attributes.each do |key|
          param = send("parent_param_#{key}")
          record[key.to_sym] = param if param
        end
      end
      result.full_name = parent_param_full_name if parent_param_full_name
      result.save() # will not trigger a second SQL query unless full_name has changed

      # save relation objects
      valid_association_attributes = Parent.reflect_on_all_associations().collect(&:name).map(&:to_s) & parent_params.keys
      valid_association_attributes.each do |key|
        params = send("parent_param_#{key}")
        klass = key.capitalize.singularize.constantize
        if params.is_a?(Array)
          params.each do |param|
            obj = klass.create(param)
            result.send(key) << obj
          end
        end
      end

      result
    end

    def raise_not_authorized!
      render_unauthorized
    end

    def parent_params_valid?
      ( parent_param_api_key ) or ( parent_param_full_name and (parent_param_email or parent_param_phone) )
    end

    def valid_parent_params
      params = {}
      if parent_param_email or parent_param_phone
        params[:email] = parent_param_email if parent_param_email
        params[:phone] = parent_param_phone if parent_param_phone
      else
        params[:api_key] = parent_param_api_key
      end
      params
    end

    def parent_params
      if params.include?(:parent)
        params.require(:parent).permit(
          :first_name,
          :last_name,
          :email,
          :phone,
          :near_address,
          :found_option_id,
          :address,
          :home_zip_code,
          :api_key,
          :full_name,
          :subscribe,
          :children => [
            :age_months,
            :schedule_year_id,
            :children_schedule_days_attributes => [
              :schedule_day_id
            ],
            :children_schedule_week_attributes => [
              :schedule_week_id
            ]
          ])
      else
        {}
      end
    end

    def parent_param_phone
      !parent_params[:phone].blank? ? parent_params[:phone].gsub(/\D/, '') : false
    end

    def parent_param_api_key
      !params[:api_key].blank? ? params[:api_key] : false
    end

    def method_missing(method_sym, *arguments, &block)
      method_name_prefix = 'parent_param_'
      if method_sym[0..method_name_prefix.length - 1] == method_name_prefix
        param = method_sym[method_name_prefix.length..method_sym.length]
        !parent_params[param.to_sym].blank? ? parent_params[param.to_sym] : false
      else
        super
      end
    end
  end
end
