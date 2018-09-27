module Api
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :set_user_by_token
    before_action :check_parent_credentials
    after_action :send_apikey

    rescue_from ActiveRecord::RecordInvalid do |error|
      render :json => {:message => error.message, :fields => error.record.errors}, :status => 422
    end

    rescue_from ActiveRecord::RecordNotFound do |error|
      render :json => {:message => 'Record not found' }, :status => 404
    end

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
        parent.set_provider
        # Update only on initial create
        if parent.new_record?
          parent.assign_attributes(parent_params)
        else
          if @resource.present?
            parent.home_zip_code = parent_params[:home_zip_code]
            # Only set attributes if they are blank
            [:phone, :email, :full_name].each do |attr|
              parent.send(attr.to_s + '=', parent_params[attr]) if parent.send(attr).blank? && !parent_params[attr].blank?
            end
          end
        end
        parent.save
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
        # email is the primary key
        params[:email] = parent_param_email if parent_param_email
        params[:phone] = parent_param_phone if parent_param_phone && !parent_param_email
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
        )
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

    def resource_name
      'parent'
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
