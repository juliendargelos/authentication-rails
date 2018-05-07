module Authentication
  module Validations
    extend ActiveSupport::Concern

    included do
      validate :succeed

      protected

      def succeed
        if public_attribute.present? && private_attribute.present? && !model&.authenticate(private_attribute)
          errors.add(:base,
            I18n.t(
              "activerecord.errors.models.#{self.class.to_s.underscore}.invalid",
              default: I18n.t(
                'activerecord.errors.messages.invalid',
                default: I18n.t('errors.messages.invalid')
              )
            )
          )
        end
      end
    end
  end
end
