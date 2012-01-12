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
        expected = File.read(File.join(folder, "#{basename}.exp"))
        template = WLang::file_template(template_file, "wlang/#{dialect_name}")
        assert_equal(expected, template.instantiate)
      end
    end
    
    Dir["#{File.dirname(__FILE__)}/*"].each do |folder|
      Dir["#{folder}/*.tpl"].each do |template_file|
        define_method_for(folder, template_file)
      end
    end
    
  end # class StandardDialectsTest
end # module WLang