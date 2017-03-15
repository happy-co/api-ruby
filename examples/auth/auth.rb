#!/usr/bin/env ruby
# usage is ./auth <client id> <secret>

require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"

auth_proc = proc { { 'authorization' => auth }}

puts "Attempting list accounts request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc

channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)

# A simple request to get the list of accounts that these credentials can manage.
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()

response = stub.list_accounts(request)

puts "Got response with #{response.accounts.count} account"
response.accounts.each do |account|
  puts account.inspect
end







