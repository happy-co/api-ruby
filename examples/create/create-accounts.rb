require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting create accounts request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

account = Happyco::Manage::Account::V1::Account.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: Time.now().to_i.to_s),
  inactive: false,
  name: 'Super Awesomeness',
  phone: '1456672902',
  address_line_1: '1000 Street St',
  address_line_2: 'Floor 10',
  city: 'San Francisco',
  state: 'CA',
  postal_code: '94109',
  country: 'USA',
)

admin = Happyco::Manage::Account::V1::User.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: '479100'),
  inactive: false,
  first_name: 'B',
  last_name: 'H',
  email: 'happy@happy.co',
  phone: '1234567890'
)

account_with_admin = Happyco::Manage::AccountProvisioning::V1::CreateAccountsRequest::AccountWithAdmin.new(
  account: account,
  admin: admin
)

stub = Happyco::Manage::AccountProvisioning::V1::AccountProvisioningService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::AccountProvisioning::V1::CreateAccountsRequest.new(
  account_with_admins: [account_with_admin]
)
response = stub.create_accounts(request)

puts "Got response with #{response.account_id_with_admin_ids.count} account"
response.account_id_with_admin_ids.each do |id|
  puts "Account id created: #{id.inspect}"
end