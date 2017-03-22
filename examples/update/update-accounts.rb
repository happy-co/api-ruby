# admin_id is not currently returned with this request preventing it from working - fix coming soon

require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting update accounts request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

account_with_admin_id = Happyco::Manage::Account::V1::UpdateAccountsRequest::AccountWithAdminId.new(
  account: response.accounts.first,
  admin: response.accounts.first.admin_id
)

stub2 = Happyco::Manage::Account::V1::AccountProvisioningService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Account::V1::UpdateAccountsRequest.new(
  account_with_admin_ids: [account_with_admin_id]
)
response2 = stub2.update_accounts(request2)

puts response2.inspect