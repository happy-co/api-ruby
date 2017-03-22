require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting inspection status changes event request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Inspect::Inspection::V1::InspectionEventService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Inspect::Inspection::V1::InspectionStatusChangesEventRequest.new(
  account_id: response.accounts.first.id,
  options: Happyco::Type::V1::EventHandlerOptions.new(ack_timeout_seconds: 30)
)
response2 = stub2.on_inspection_status_changes(request2)

i = 0
response2.each do |status_change|
  puts status_change.inspect
  break if i > 1
  i = i + 1
end