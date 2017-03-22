require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting add users request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

user = Happyco::Manage::Account::V1::User.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: Time.now().to_i.to_s),
  inactive: false,
  first_name: 'Brittney',
  last_name: 'Hodson',
  email: 'brittney' + Time.now().to_i.to_s + '@happy.co',
  phone: '1234567890'
)

stub2 = Happyco::Manage::Account::V1::AccountUsersService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Account::V1::AddUsersRequest.new(
  account_id: response.accounts.first.id,
  users: [user]
)
response2 = stub2.add_users(request2)

puts "Got response with #{response2.user_ids.count} users"
response2.user_ids.each do |id|
  puts "User id created: #{id.inspect}"
end