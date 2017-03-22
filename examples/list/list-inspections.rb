require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting list inspections request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Inspect::Inspection::V1::InspectionService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Inspect::Inspection::V1::ListInspectionsRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_inspections(request2)

puts "Got response with #{response2.inspections.count} inspections"
response2.inspections.each do |inspection|
  puts inspection.inspect
end