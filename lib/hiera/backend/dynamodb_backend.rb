class Hiera
  module Backend
    # Hiera DynamoDB backend
    class Dynamodb_backend
      def initialize
        begin
          require 'aws-sdk-dynamodb'
          require 'rubygems'
        end
      end

      def lookup(key, scope, order_override, resolution_type)
        if Config.include?(:dynamodb) && !Config[:dynamodb].nil?
          aws_config = {}
          if Config[:dynamodb].include?(:access_key_id) && Config[:dynamodb].include?(:secret_access_key)
            Hiera.debug("Found AWS Access Key #{Config[:dynamodb][:access_key_id]} from configuration")
            aws_config[:access_key_id] = Config[:dynamodb][:access_key_id]
            aws_config[:secret_access_key] = Config[:dynamodb][:secret_access_key]
          end
          if Config[:dynamodb].include?(:region)
            Hiera.debug("Found AWS region #{Config[:dynamodb][:region]} from configuration")
            aws_config[:region] = Config[:dynamodb][:region]
          end
          if aws_config.length != 0
            Hiera.debug('loading DynamoDB backend')
            ddb = Aws::DynamoDB::Client.new(aws_config)
          else
            Hiera.debug('No AWS configuration found, will fall back to env variables or IAM role')
            ddb = Aws::DynamoDB::Client.new
          end
        else
          Hiera.debug('No configuration found, will fall back to env variables or IAM role')
          ddb = Aws::DynamoDB::Client.new
        end
        if Config[:dynamodb].include?(:table)
          table = Config[:dynamodb][:table]
        else
          table = 'puppet'
        end
        Hiera.debug("Hiera dynamodb Client connected. Checking that table: #{table} requested in config exists")
        exists = ddb.list_tables({})
        Hiera.debug(exists)
        Hiera.debug("Looking for #{key}")
        resp = ddb.get_item({
          key: {
            "hiera_key" => key,
          },
          table_name: table,
        })
        Hiera.debug(resp.to_h)
        items = resp.to_h[:item]
        Hiera.debug(items)
        answer = items["hiera_value"]
        Hiera.debug("Value Returned: #{answer}")
        return answer
      end
    end
  end
end
