require 'rails/railtie'

module Authentication
  module Rails
    require __dir__ + '/engine'
    require __dir__ + '/core_ext'

    require __dir__ + '/validations'
    require __dir__ + '/attributes'
    require __dir__ + '/storage'
    require __dir__ + '/comparisons'

    require __dir__ + '/base'
  end
end
