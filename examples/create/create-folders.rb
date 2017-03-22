require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting create folders request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

folder = Happyco::Manage::Folder::V1::Folder.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: Time.now().to_i.to_s),
  inactive: false,
  name: 'Brittneys Test Folder',
  type: 0
)

stub2 = Happyco::Manage::Folder::V1::FolderService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Folder::V1::CreateFoldersRequest.new(
  account_id: response.accounts.first.id,
  folders: [folder])
response2 = stub2.create_folders(request2)

puts "Got response with #{response2.folder_ids.count} folders"
response2.folder_ids.each do |id|
  puts "Folder id created: #{id.inspect}"
end