#!/usr/bin/ruby

require 'aws-sdk'
require 'yaml'
require 'optparse'

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
s3 = AWS::S3.new({
      region: creds[:region],
      access_key_id: creds[:access_key_id],
      secret_access_key: creds[:secret_access_key]
    })
if options[:action] == :list then
        s3.buckets.each do |bucket|
          puts bucket
        end
else
        raise OptionParser::MissingArgument, "\nPlease provide a valid action" if options[:bucket_name].nil?

        if options[:action] == :upload then
#           new_inst = ec2.stop_instances({
#             dry_run: false,
#             instance_ids: [options[:server_id]],
#             force: false,
#           })
#
        elsif options[:action] == :delete then
#         		new_inst = ec2.start_instances({
#         		  instance_ids: [options[:server_id]], # required
#         		  dry_run: false,
#         		})
#         		new_inst = ec2.wait_until(:instance_running, instance_ids:[options[:server_id]])
#         		puts new_inst.reservations[0].instances[0].public_dns_name
#
        elsif options[:action] == :download then
#       		new_inst = ec2.terminate_instances({
#       		  dry_run: false,
#       		  instance_ids: [options[:server_id]],
#       		})
#       	end
# end
