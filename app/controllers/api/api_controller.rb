module Api
  class ApiController < ApplicationController
    # before_action :check_parent_credentials
    # after_action :send_apikey

    private

    def check_parent_credentials
      @current_parent = get_parent if parent_params_valid?
      raise_not_authorized! unless @current_parent and @current_parent.persisted?
    end

    def send_apikey
      response.headers['Cc-Apikey'] = @current_parent.api_key
    end

    def get_parent
      parent = Parent.where(valid_parent_params).first_or_create
      if has_parent_data
        parent.care_reasons.destroy_all
        parent.care_types.destroy_all
        parent.children.destroy_all
        parent.update(parent_params)
      end
      parent
    end

    def raise_not_authorized!
      render_unauthorized
    end

    def parent_params_valid?
      ( parent_param_api_key ) or ( parent_param_full_name and (parent_param_email or parent_param_phone) )
    end

    def has_parent_data
      !parent_param_api_key and parent_param_full_name and (parent_param_email or parent_param_phone)
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
          :found_option_id,
          # :agree,
          parents_care_reasons_attributes: [
            :care_reason_id
          ],
          parents_care_types_attributes: [
            :care_type_id
          ],
          children_attributes: [
            :age_months,
            :schedule_year_id,
            children_schedule_days_attributes: [
              :schedule_day_id
            ],
            children_schedule_weeks_attributes: [
              :schedule_week_id
            ],
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
