here = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(here, '..', '..', 'lib'))
require 'wlang'
require 'test/unit'
module WLang
  class StandardDialectsTest < Test::Unit::TestCase
    
    Dir["#{File.dirname(__FILE__)}/*"].each do |folder|
      dialect_name = File.basename(folder)
      Dir["#{folder}/*.tpl"].each do |template_file|
        basename = File.basename(template_file, ".tpl")
        
        define_method("test_#{dialect_name}_#{basename}") do 
          expected = File.read(File.join(folder, "#{basename}.exp"))
          template = WLang::file_template(template_file, "wlang/#{dialect_name}")
          assert_equal(expected, template.instantiate)
        end

      end
    end
    
  end # class StandardDialectsTest
end # module WLang