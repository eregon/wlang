module WLang
  class Dialect
    module DSL
      
      module ClassMethods
        
        protected
        
        def tag(symbols, method = nil, &block)
          define_tag_method(symbols, method || block)
        end
        
      end
      
      module InstanceMethods
        
        protected
        
        def instantiate(fn, dialect = self)
          case fn
          when Template
            fn.call(@scope)
          when Proc
            dialect = dialect.new if dialect.is_a?(Class)
            fn.call(dialect, "")
          when String
            self.class.instantiate(fn, @scope)
          end
        end
        
        def evaluate(what, dialect = self)
          what = what.call(dialect, "") if what.is_a?(Proc)
          what.strip == "self" ? @scope : @scope.instance_eval(what)
        end
        
        def with_scope(scope)
          old, @scope = @scope, Scope.factor(scope)
          yield
        ensure
          @scope = scope
        end
        
        def known?(what)
          @scope.respond_to?(what.to_sym)
        end
        
      end
      
      def self.included(mod)
        mod.instance_eval{ include(InstanceMethods) }
        mod.extend(ClassMethods)
      end
      
    end # module DSL
  end # class Dialect
end # module WLang