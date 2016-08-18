#!/usr/bin/ruby

require 'aws-sdk'
require 'yaml'
require 'optparse'
require 'rubygems'

options = {}
opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: 0-basic_aws_s3_script.rb [options]"

        opts.separator ""
opts.separator "Specific options:"

    opts.on('-a', '--action [ACTION]', [:list, :upload, :delete, :download],
            'Select action to perform [list, upload, delete, download]') do |v|
            if not v then
                    puts "Error: Action not valid"
            else
                    options[:action] = v
            end
    end

    opts.on('-b', '--bucketname [BUCKET_NAME]', 'Name of the bucket to perform the action on') do |v|
            options[:bucket_name] = v
    end

    opts.on('-f', '--filepath [FILE_PATH]', 'Provides the path to the file to upload') do |v|
            options[:file_path] = v
    end

    opts.on('-v', '--verbose', 'Run verbosely') do |v|
            options[:verbose] = v
    end

    opts.on('-h', '--help', 'returns the help menu') do |v|
            puts opts
            exit
    end
end

opt_parser.parse!(ARGV)
raise OptionParser::MissingArgument, "\nPlease provide an action (list, upload, delete, download)" if options[:action].nil?
creds = YAML.load_file('config.yaml')

s3 = Aws::S3::Resource.new({
      region: creds[:region],
      access_key_id: creds[:access_key_id],
      secret_access_key: creds[:secret_access_key]
    })

    #  raise OptionParser::MissingArgument, "\nPlease provide a valid action" if options['b'].nil?

# to upload
# Create an instance of the Aws::S3::Resource class
# Reference the target object by bucket name and key
# Call#upload_file on the object
        if options[:action] == :upload then
          file = '/Users/krisbredemeier/Downloads/holberton-logo.png'
          name = File.basename(file)
          obj = s3.bucket('bredemeier').object(name)
          obj.upload_file(file)

        elsif options[:action] == :list then
                  s3.buckets.each do |bucket|
                      puts "#{bucket.name}\t#{bucket.creation_date}"
                  end
        elsif options[:action] == :delete then

        elsif options[:action] == :download then

      	# end
end
