require 'spec_helper'
module WLang
  describe Parser do
    
    let(:parser){ WLang::Parser.new }

    it 'should parse as expected' do
      expected = \
        [:concat,
          [:static, "Hello "],
          [:wlang,  "$",
            [:fn, 
              [:concat, [:static, "world"]]
            ]
          ],
          [:static, "!"]
        ]
      parser.call("Hello ${world}!").should eq(expected)
    end
    
  end
end