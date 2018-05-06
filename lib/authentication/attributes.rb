module Authentication
  module Attributes
    extend ActiveSupport::Concern

    DEFAULT_ID_ATTRIBUTE = :id
    DEFAULT_PUBLIC_ATTRIBUTE = :email
    DEFAULT_PRIVATE_ATTRIBUTE = :password

    included do
      attr_accessor :public_attribute, :private_attribute

      def id
        return nil if model.blank?
        model.send self.class.id_attribute
      end

      def id=(v)
        return self.model = nil if v.nil?
        self.model = self.class.authenticated_model.find_by self.class.id_attribute => v
      end

      def model
        return nil if public_attribute.blank?
        self.class.authenticated_model.find_by self.class.public_attribute => public_attribute
      end

      def model=(v)
        self.public_attribute = v.try self.class.public_attribute
      end
    end

    class_methods do
      attr_reader :authenticated_model

      def has_model(name)
        alias_accessor :model, :authenticated_model_name do
          @authenticated_model = name.present? ? name.to_s.classify.constantize : nil
        end
      end

      def has_id(attribute)
        alias_accessor :id, :id_attribute do
          @id_attribute = attribute.to_s.to_sym.presence
        end
      end

      def has_public(attribute)
        alias_accessor :public_attribute do
          @public_attribute = attribute.to_s.to_sym.presence
        end
      end

      def has_private(attribute)
        alias_accessor :private_attribute do
          @private_attribute = attribute.to_s.to_sym.presence
        end
      end

      def authenticated_model_name
        authenticated_model.present? ? authenticated_model.to_s.underscore.gsub('/', '_').to_sym : :model
      end

      def id_attribute
        @id_attribute || DEFAULT_ID_ATTRIBUTE
      end

      def public_attribute
        @public_attribute || DEFAULT_PUBLIC_ATTRIBUTE
      end

      def private_attribute
        @private_attribute || DEFAULT_PRIVATE_ATTRIBUTE
      end

      def columns
        [
          Struct.new(:name, :type).new(public_attribute, :string),
          Struct.new(:name, :type).new(private_attribute, :string)
        ]
      end

      protected

      def alias_accessor(name, name_method = nil)
        method_name = send name_method || name
        if method_name.present? && method_name.to_s != name.to_s
          remove_method method_name if respond_to? method_name
          remove_method "#{method_name}=" if respond_to? "#{method_name}="
        end

        yield

        method_name = send name_method || name
        if method_name.to_s != name.to_s
          alias_method method_name, name
          alias_method "#{method_name}=", "#{name}="
        end
      end
    end
  end
end
