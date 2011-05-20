require 'aws'
require 'json'

module Akoe
  class Queue < Aws::Sqs::Queue
    def initialize(title)
      access_id = ENV["S3_ACCESS_ID"]
      secret_key = ENV["S3_SECRET_KEY"]
      @sqs = Aws::Sqs.new(access_id, secret_key)
      Aws::Sqs::Queue.create(@sqs, title, true)
      super(@sqs, title)
    end

    def send_job(job)
      hash = {:type => job.type,
              :s3_source => job.s3_source,
              :s3_destination => job.s3_destination}
      message = hash.to_json
      send_message(message)
    end

    def receive_job
      message = pop
      hash = JSON.parse(message.body) unless message.nil?
      job = Job.new({:type => hash['type'],
                     :s3_source => hash['s3_source'],
                     :s3_destination => hash['s3_destination']})
    end
  end
end