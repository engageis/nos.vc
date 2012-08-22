require 'spec_helper'

describe DynamicField do
  describe "validations" do
    subject { Factory(:dynamic_field) }

    it { should validate_presence_of :input_name }
   end

  describe "associations" do
    subject { Factory(:dynamic_field) }

    it { should belong_to(:project) }
    it { should have_many(:dynamic_values) }
  end
end
