require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting update users request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Manage::Account::V1::AccountUsersService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Account::V1::ListUsersRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_users(request2)

user = Happyco::Manage::Account::V1::User.new(
  id: response2.users.first.id,
  inactive: false,
  first_name: 'Brit',
  last_name: 'Hodson',
  email: 'bmh' + Time.now().to_i.to_s + '@happy.co',
  phone: '1234567888'
)

request3 = Happyco::Manage::Account::V1::UpdateUsersRequest.new(
  account_id: response.accounts.first.id,
  users: [user]
)
response3 = stub2.update_users(request3)

puts "Got response with #{response3.user_ids.count} users"
response3.user_ids.each do |id|
  puts "Updated user with id: #{id.inspect}"
end