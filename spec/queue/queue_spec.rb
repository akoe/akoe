require 'spec_helper'

describe Akoe::Queue do
  subject { Akoe::Queue.new("my_queue") }
  before(:all) do
    subject.clear # you must delete and rebuild a queue to *absolutely* clear it
  end
  it "should read queue size" do
    subject.should respond_to(:size)
  end
  it "should clear all messages" do
    subject.clear
  end
  it "should send a message" do
    subject.send_message("hey hey")
  end
  it "should read a message" do
    subject.send_message("hey hey")
    subject.receive_message.should == "hey hey"
  end
end