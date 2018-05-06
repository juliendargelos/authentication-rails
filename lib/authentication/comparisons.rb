module Authentication
  module Comparisons
    extend ActiveSupport::Concern

    included do
      def ==(authentication)
        authentication.is_a?(self.class) && id.present? && id == authentication.id
      end
    end
  end
end
