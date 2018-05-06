ActionController::Base.class_eval do
  before_action :initialize_authentication

  class << self
    protected

    def authenticates(model = nil, options = {}, &hook)
      authentication = authentication_class_for model, options

      define_method authentication_hook_name_for(:success, nil, class_name: authentication) do
        instance_eval &hook unless authentication.current.exists?
      end
    end

    def unauthenticates(model = nil, options = {}, &hook)
      authentication = authentication_class_for model, options

      define_method authentication_hook_name_for(:fail, nil, class_name: authentication) do
        instance_eval &hook if authentication.current.exists?
      end
    end

    def authenticates!(model = nil, options = {})
      before_action authentication_hook_name_for(:success, model, options), options.except(:class_name)
    end

    def doesnt_authenticate!(model = nil, options = {})
      skip_before_action authentication_hook_name_for(:success, model, options), options.except(:class_name)
    end

    def unauthenticates!(model = nil, options = {})
      before_action authentication_hook_name_for(:fail, model, options), options.except(:class_name)
    end

    def doesnt_unauthenticate!(model = nil, options = {})
      bskip_efore_action authentication_hook_name_for(:fail, model, options), options.except(:class_name)
    end

    def authentication_class_for(model, options)
      (options[:class_name].presence || "#{model.to_s.classify}::Authentication").to_s.constantize
    end

    def authentication_hook_name_for(type, model, options)
      authentication = authentication_class_for model, options
      "#{authentication.to_s.underscore.gsub '/', '_'}_#{type}_hook".to_sym
    end
  end

  protected

  def initialize_authentication
    Authentication::Base.store = session
  end
end
