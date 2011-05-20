module Akoe
  class Job 
    attr_accessor :type, :s3_source, :s3_destination

    def initialize(options={})
      @type = options[:type]
      @s3_source = options[:s3_source]
      @s3_destination = options[:s3_destination]
    end

    # validations
    def execute
    end
  end
end