here = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(here, '..', '..', 'lib'))
require 'wlang'
require 'test/unit'
module WLang
  class StandardDialectsTest < Test::Unit::TestCase

    def self.define_method_for(folder, template_file)
      dialect_name = File.basename(folder)
      basename = File.basename(template_file, ".tpl")

      define_method("test_#{dialect_name}_#{basename}") do 
        exp_file = File.join(File.dirname(template_file), "#{basename}.exp")
        expected = File.read(exp_file)
        template = WLang::file_template(template_file, "wlang/#{dialect_name}")
        obtained = template.instantiate
        ass_file = File.join(File.dirname(template_file), "#{basename}.ass")
        if File.exists?(ass_file)
          Kernel.eval(File.read(ass_file), binding, ass_file)
        else
          assert_equal(expected, obtained)
        end
      end

    end
    
    Dir["#{File.dirname(__FILE__)}/*"].each do |folder|
      Dir["#{folder}/*.tpl"].each do |template_file|
        define_method_for(folder, template_file)
      end
      if RUBY_VERSION < "1.9"
        Dir["#{folder}/1.8/*.tpl"].each do |template_file|
          define_method_for(folder, template_file)
        end
      else
        Dir["#{folder}/1.9/*.tpl"].each do |template_file|
          define_method_for(folder, template_file)
        end
      end
    end
    
  end # class StandardDialectsTest
end # module WLang