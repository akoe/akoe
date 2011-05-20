require 'spec_helper'

describe Akoe::Job do
  context "Validations" do
    %w[type s3_source s3_destination].each do |attr|
      it "has #{attr}" do
        subject.should respond_to(attr)
      end
    end
  end
  it "should execute" do
    subject.should respond_to(:execute)
  end
end