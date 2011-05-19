require 'aws'

module Akoe
  class Queue
    attr_reader :title

    def initialize(title)
      access_id = ENV["S3_ACCESS_ID"]
      secret_key = ENV["S3_SECRET_KEY"]

      @sqs = Aws::Sqs.new(access_id, secret_key)
      @title = title
      @queue = @sqs.queue(title, true)
    end

    def size
      @queue.size
    end

    def clear
      # NOTE: Any message within the visibility timeout will not be deleted!
      @queue.clear
    end

    def send_message(msg)
      @queue.send_message(msg)
    end

    def receive_message
      message = @queue.receive
      message.body unless message.nil?
    end
  end
end