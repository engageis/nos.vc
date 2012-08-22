require 'spec_helper'

describe DynamicField do
  describe "validations" do
    subject { Factory(:dynamic_field) }

    it { should belong_to(:project) }
    it{ should validate_presence_of :input_name }
   end
end
