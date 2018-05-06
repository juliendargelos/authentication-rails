module Authentication
  class Base
    include ActiveModel::Model

    include Validations
    include Attributes
    include Storage
    include Comparisons
  end
end
