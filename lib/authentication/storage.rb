module Authentication
  module Storage
    extend ActiveSupport::Concern

    included do
      def save
        if validate
          self.class.current = self
          return true
        else
          return false
        end
      end

      def destroy
        self.class.current = nil
      end

      def persisted?
        self.class.current == self
      end
      alias_method :exists?, :persisted?
    end

    class_methods do
      attr_writer :store

      def store
        @store.present? ? @store : (self == Authentication::Base ? nil : Authentication::Base.store)
      end

      def current
        new id: store&.[](store_key)
      end

      def current=(v)
        store&.[]=(store_key, v&.id)
      end

      protected

      def store_key
        :"#{to_s.underscore.gsub '/', '_'}_#{id_attribute}"
      end
    end
  end
end
