require 'rails_helper'

RSpec.describe Driver, :type => :model do
	subject {described_class.new}

  it "is valid with valid phone" do
  	subject.phone = "0508801391"
  	expect(subject).to be_valid
  end
  it "is not valid without a phone"	do
  	subject.phone = nil
  	expect(subject).to_not be_valid
  end

  it "is not valid with wrong phone" do
  	subject.phone = "lol"
  	expect(subject).to_not be_valid
  end
end
