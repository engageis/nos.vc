require 'spec_helper'

describe DynamicValue do
  describe "associations" do
    subject { Factory(:dynamic_value) }

    it { should belong_to(:dynamic_field) }
    it { should belong_to(:backer) }
   end
end
