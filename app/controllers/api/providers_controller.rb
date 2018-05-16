module Api
  class ProvidersController < ApiController
    before_action :create_referral_log, only: :index

    def index
      provider_size = 40
      providers = [] # NDS.search()

      response = {
        "total" => 1,
        "providers" => [
          {
            "id" => 2340,
            "name" => "Sukitha Wanigtunga",
            "alternate_name" => "Montessori House of Children",
            "contact_name" => "Sukitha Wanigtunga",
            "phone" => "4154417691",
            "phone_ext" => "xx",
            "phone_other" => "xxxxxxxxxx",
            "phone_other_ext" => "xx",
            "fax" => "4154411176",
            "email" => "rohan11@pacbell.net",
            "url" => "www.montessorisf.net",
            "address_1" => "1187 Franklin St, Unit No. xx, San Francisco, CA  94109-xxxx",
            "address_2" => nil,
            "city_id" => 5,
            "state_id" => 5,
            "images" => ProviderImageService.get(2340),
            "cross_street_1" => "Franklin St",
            "cross_street_2" => "Geary Blvd",
            "mail_address_1" => "1187 Franklin St, Unit No. xx, San Francisco, CA  94109-xxxx",
            "mail_address_2" => nil,
            "mail_city_id" => 5,
            "mail_state_id" => 5,
            "ssn" => nil,
            "tax_id" => nil,
            "created_at" => "2017-11-14T00:00:00.000Z",
            "updated_at" => "2017-11-15T14:33:35.574Z",
            "latitude" => 37.7850236,
            "longitude" => -122.4234717,
            "schedule_year_id" => 1,
            "zip_code_id" => 23,
            "care_type_id" => 2,
            "description" => nil,
            "licensed_ages" => [24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71],
            "neighborhood_id"=> 9,
            "mail_zip_code" => "94109",
            "accepting_referrals" => true,
            "meals_optional" => false,
            "meal_sponsor_id" => nil,
            "english_capability" => "taking_esl",
            "preferred_language_id" => 1,
            "potty_training":false,
            "co_op":false,
            "nutrition_program":true,
            "cached_geocodable_address_string" => "1187 Franklin St, Unit No. xx, San Francisco, CA  94109-xxxx,  San Francisco, California, 94109",
            "distance":0.185187520510558,
            "bearing" => "298.251391774534",
            "licenses":[{"id":14765,"provider_id":766,"date":nil,"exempt":false,"license_type" => "fcc",
              "number" => "380501318",
              "capacity":110,"capacity_desired":110,"capacity_subsidy":nil,"age_from_year":2,"age_from_month":0,"age_to_year":5,"age_to_month":11,"vacancies":6,"created_at" => "2018-04-11T00:00:00.000Z",
              "updated_at" => "2018-04-11T00:00:00.000Z"}],"schedule_hours":[{"id":49982,"schedule_day_id":1,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                "end_time" => "2000-01-01T18:00:00.000Z",
                "closed":true,"created_at" => "2001-09-19T00:00:00.000Z",
                "updated_at" => "2017-03-22T00:00:00.000Z",
                "open_24":false},{"id":49983,"schedule_day_id":2,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                  "end_time" => "2000-01-01T18:00:00.000Z",
                  "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                  "updated_at" => "2017-03-22T00:00:00.000Z",
                  "open_24":false},{"id":49984,"schedule_day_id":3,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                    "end_time" => "2000-01-01T18:00:00.000Z",
                    "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                    "updated_at" => "2017-03-22T00:00:00.000Z",
                    "open_24":false},{"id":49985,"schedule_day_id":4,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                      "end_time" => "2000-01-01T18:00:00.000Z",
                      "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                      "updated_at" => "2017-03-22T00:00:00.000Z",
                      "open_24":false},{"id":49986,"schedule_day_id":5,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                        "end_time" => "2000-01-01T18:00:00.000Z",
                        "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                        "updated_at" => "2017-03-22T00:00:00.000Z",
                        "open_24":false},{"id":49987,"schedule_day_id":6,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                          "end_time" => "2000-01-01T18:00:00.000Z",
                          "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                          "updated_at" => "2017-03-22T00:00:00.000Z",
                          "open_24":false},{"id":49988,"schedule_day_id":7,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                            "end_time" => "2000-01-01T18:00:00.000Z",
                            "closed":true,"created_at" => "2001-09-19T00:00:00.000Z",
                            "updated_at" => "2017-03-22T00:00:00.000Z",
                            "open_24":false}],"subsidies":[{"id":3,"name" => "CalWORKs/AP Vouchers",
                              "created_at" => "2017-11-13T21:30:01.860Z",
                              "updated_at" => "2017-11-13T21:30:01.860Z",
                              "description" => "This option only applies for families currently receiving CalWORKs benefits. You may select this option to view child care providers that accept vouchers (child care payments from CalWORKs). Keep in mind that some providers may have not notified us that they accept vouchers.",
                              "display":true}]
        },
        {
          "id" => 2310,
          "name" => "Sukitha Wanigtunga",
          "alternate_name" => "Montessori House of Children",
          "contact_name" => "Sukitha Wanigtunga",
          "phone" => "4154417691",
          "phone_ext" => "xx",
          "phone_other" => "xxxxxxxxxx",
          "phone_other_ext" => "xx",
          "fax" => "4154411176",
          "email" => "rohan11@pacbell.net",
          "url" => "www.montessorisf.net",
          "address_1" => "1187 Franklin St, Unit No. xx, San Francisco, CA  94109-xxxx",
          "address_2" => nil,
          "city_id" => 5,
          "state_id" => 5,
          "images" => ProviderImageService.get(2310),
          "cross_street_1" => "Franklin St",
          "cross_street_2" => "Geary Blvd",
          "mail_address_1" => "1187 Franklin St, Unit No. xx, San Francisco, CA  94109-xxxx",
          "mail_address_2" => nil,
          "mail_city_id" => 5,
          "mail_state_id" => 5,
          "ssn" => nil,
          "tax_id" => nil,
          "created_at" => "2017-11-14T00:00:00.000Z",
          "updated_at" => "2017-11-15T14:33:35.574Z",
          "latitude" => 37.7850236,
          "longitude" => -122.4234717,
          "schedule_year_id" => 1,
          "zip_code_id" => 23,
          "care_type_id" => 2,
          "description" => nil,
          "licensed_ages" => [24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71],
          "neighborhood_id"=> 9,
          "mail_zip_code" => "94109",
          "accepting_referrals" => true,
          "meals_optional" => false,
          "meal_sponsor_id" => nil,
          "english_capability" => "taking_esl",
          "preferred_language_id" => 1,
          "potty_training":false,
          "co_op":false,
          "nutrition_program":true,
          "cached_geocodable_address_string" => "1187 Franklin St, Unit No. xx, San Francisco, CA  94109-xxxx,  San Francisco, California, 94109",
          "distance":0.185187520510558,
          "bearing" => "298.251391774534",
          "licenses":[{"id":14765,"provider_id":766,"date":nil,"exempt":false,"license_type" => "fcc",
            "number" => "380501318",
            "capacity":110,"capacity_desired":110,"capacity_subsidy":nil,"age_from_year":2,"age_from_month":0,"age_to_year":5,"age_to_month":11,"vacancies":6,"created_at" => "2018-04-11T00:00:00.000Z",
            "updated_at" => "2018-04-11T00:00:00.000Z"}],"schedule_hours":[{"id":49982,"schedule_day_id":1,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
              "end_time" => "2000-01-01T18:00:00.000Z",
              "closed":true,"created_at" => "2001-09-19T00:00:00.000Z",
              "updated_at" => "2017-03-22T00:00:00.000Z",
              "open_24":false},{"id":49983,"schedule_day_id":2,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                "end_time" => "2000-01-01T18:00:00.000Z",
                "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                "updated_at" => "2017-03-22T00:00:00.000Z",
                "open_24":false},{"id":49984,"schedule_day_id":3,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                  "end_time" => "2000-01-01T18:00:00.000Z",
                  "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                  "updated_at" => "2017-03-22T00:00:00.000Z",
                  "open_24":false},{"id":49985,"schedule_day_id":4,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                    "end_time" => "2000-01-01T18:00:00.000Z",
                    "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                    "updated_at" => "2017-03-22T00:00:00.000Z",
                    "open_24":false},{"id":49986,"schedule_day_id":5,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                      "end_time" => "2000-01-01T18:00:00.000Z",
                      "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                      "updated_at" => "2017-03-22T00:00:00.000Z",
                      "open_24":false},{"id":49987,"schedule_day_id":6,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                        "end_time" => "2000-01-01T18:00:00.000Z",
                        "closed":false,"created_at" => "2001-09-19T00:00:00.000Z",
                        "updated_at" => "2017-03-22T00:00:00.000Z",
                        "open_24":false},{"id":49988,"schedule_day_id":7,"provider_id":766,"start_time" => "2000-01-01T07:00:00.000Z",
                          "end_time" => "2000-01-01T18:00:00.000Z",
                          "closed":true,"created_at" => "2001-09-19T00:00:00.000Z",
                          "updated_at" => "2017-03-22T00:00:00.000Z",
                          "open_24":false}],"subsidies":[{"id":3,"name" => "CalWORKs/AP Vouchers",
                            "created_at" => "2017-11-13T21:30:01.860Z",
                            "updated_at" => "2017-11-13T21:30:01.860Z",
                            "description" => "This option only applies for families currently receiving CalWORKs benefits. You may select this option to view child care providers that accept vouchers (child care payments from CalWORKs). Keep in mind that some providers may have not notified us that they accept vouchers.",
                            "display":true}]
      }]
      }

      render json: response, status: 200
    end

    def show
      @provider = nds_provider
      @provider[:images] = provider_images
      render json: @provider, status: 200
    end

    private

    def nds_provider
      NDS.provider_by_id(provider_id)
    end

    def provider_images
      ProviderImageService.get(provider_id)
    end

    def provider_id
      params[:id]
    end

    def create_referral_log
      # if parent_params[:parents_care_reasons_attributes]
      #   care_reason_ids = parent_params[:parents_care_reasons_attributes].collect{|pcra| pcra["care_reason_id"]}
      # else
      #   care_reason_ids = @current_parent.care_reasons.collect(&:id)
      # end

      # NDS.create_referral(
      #         params: params,
      #         parent: @current_parent,
      #         child_age_months: provider_param_ages.first,
      #         schedule_week_ids: provider_param_schedule_week_ids,
      #         schedule_year_id: provider_param_schedule_year_ids.first,
      #         care_reason_ids: care_reason_ids
      #       )
    end

    def provider_params
      params.require(:providers).permit(
        :near_address,
        :co_op,
        :meals_included,
        :potty_training,

        subsidy_ids: [],
        program_ids: [],

        ages: [],
        care_type_ids: [],
        language_ids: [],
        neighborhood_ids: [],
        open_days: [],
        schedule_day_ids: [],
        schedule_week_ids: [],
        schedule_year_ids: [],
        zip_code_ids: [],
      )
    end

    def method_missing(method_sym, *arguments, &block)
      method_name_prefix = 'provider_param_'
      if method_sym[0..method_name_prefix.length - 1] == method_name_prefix
        param = method_sym[method_name_prefix.length..method_sym.length]
        !provider_params[param.to_sym].blank? ? provider_params[param.to_sym] : false
      else
        super
      end
    end
  end
end
