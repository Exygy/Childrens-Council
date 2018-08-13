module StatusType
  extend ActiveSupport::Concern

  included do
    enum status_type: {
      inactive: 0,
      temporarily_inactive: 1,
      active: 2,
    }
  end
end
