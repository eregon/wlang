module Tilt
  class WLangTemplate < ::Tilt::Template

    def self.engine_initialized?
      defined? ::WLang
    end

    def initialize_engine
      require_template_library('wlang')
    end

    protected

      def dialect
        options[:dialect] || default_dialect
      end

      def default_dialect
        require 'wlang/html' unless defined?(WLang::Html)
        WLang::Html
      end

      def prepare
        @engine = dialect.compile(data)
      end

      def evaluate(scope, locals, &block)
        locals[:yield] = block if block
        @engine.render WLang::Scope.coerce(scope).push(locals)
      end

  end
  register WLangTemplate, 'wlang'
end