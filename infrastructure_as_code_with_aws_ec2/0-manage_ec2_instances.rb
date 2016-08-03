#!/usr/bin/ruby

require 'aws-sdk'
require 'yaml'
require 'optparse'

options = {}
opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: 0-manage_ec2_instances.rb [options]"

        opts.separator ""
opts.separator "Specific options:"

    opts.on('-a', '--action [ACTION]', [:launch, :stop, :start, :terminate],
            'select action type (launch, stop, start, terminae)') do |v|
            if not v then
                    puts "Error: Action not valid"
            else
                    options[:action] = v
            end
    end

    opts.on('-i', '--server_id [SERVER_ID]', 'provides the server id when rquired') do |v|
            options[:server_id] = v
    end

    opts.on('-v', '--verbose', 'Provides extra information while the script is running') do |v|
            options[:verbose] = v
    end

    opts.on('-h', '--help', 'show this message') do |v|
            puts opts
            exit
    end
end

opt_parser.parse!(ARGV)

raise OptionParser::MissingArgument, "\nPlease provide an action (launch, stop, start, terminate)" if options[:action].nil?

creds = YAML.load_file('config.yaml')
ec2 = Aws::EC2::Client.new(
      region: 'us-west-2',
      credentials: Aws::Credentials.new(creds[:access_key_id], creds[:secret_access_key]))

if options[:action] == :launch then
        new_inst = ec2.run_instances({
                        dry_run: false,
                image_id: creds[:image_id],
                key_pair: creds['key_pair'],
                instance_type: creds["instance_type"],
                security_group_ids: creds["security_group_ids"],
                min_count: 1,
                max_count: 1,
                placement: {
                        availabilityZone: creds["availability-zone"],
                    }
              })
        instance_id = new_inst.instances[0].instance_id
        new_inst = ec2.wait_unitl(:instance_running, instance_ids:[instance_id])
        puts instance_id, new_inst.reservations[0].instances[0].public_DNS_name
else
        raise OptionParser::MissingArgument, "\nPlease provide a valid SERVER_ID" if options[:server_id].nil?

        if options[:action] == :stop then
          new_inst = ec2.stop_instances({
            dry_run: false,
            instance_ids: [options[:server_id]],
            force: false,
          })

        elsif options[:action] == :start then
        		new_inst = ec2.start_instances({
        		  instance_ids: [options[:server_id]], # required
        		  dry_run: false,
        		})
        		new_inst = ec2.wait_until(:instance_running, instance_ids:[options[:server_id]])
        		puts new_inst.reservations[0].instances[0].public_dns_name

        elsif options[:action] == :terminate then
      		new_inst = ec2.terminate_instances({
      		  dry_run: false,
      		  instance_ids: [options[:server_id]],
      		})
      	end
end
