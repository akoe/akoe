require 'aws'

module Akoe
  class Queue < Aws::Sqs::Queue
    def initialize(title)
      access_id = ENV["S3_ACCESS_ID"]
      secret_key = ENV["S3_SECRET_KEY"]
      @sqs = Aws::Sqs.new(access_id, secret_key)
      Aws::Sqs::Queue.create(@sqs, title, true)
      super(@sqs, title)
    end

    def receive_message
      message = pop
      message.body unless message.nil?
    end
  end
end