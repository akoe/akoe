require 'spec_helper'

describe Akoe::Queue do
  subject { Akoe::Queue.new("my_queue#{rand(100)}") }
  before(:all) do
    subject.clear # you must delete and rebuild a queue to *absolutely* clear it
    @job = Akoe::Job.new({:type => "transcode",
                          :s3_source => "source/s3/file.wav",
                          :s3_destination => "dest/s3/file.wav"})
  end
  it "should read queue size" do
    subject.should respond_to(:size)
  end
  it "should clear all messages" do
    subject.clear
  end
  it "should send a job" do
    subject.send_job(@job)
  end
  it "should receive a job" do
    job = subject.receive_job
    job.type.should == "transcode"
    job.s3_source.should == "source/s3/file.wav"
    job.s3_destination.should == "dest/s3/file.wav"
  end
end