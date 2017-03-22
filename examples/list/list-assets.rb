require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting list assets request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Manage::Folder::V1::FolderService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Folder::V1::ListFoldersRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_folders(request2)

stub3 = Happyco::Manage::Asset::V1::AssetService::Stub.new(host, credentials, timeout: 30)
request3 = Happyco::Manage::Asset::V1::ListAssetsRequest.new(
  account_id: response.accounts.first.id, 
  folder_id: response2.folders.first.id
)
response3 = stub3.list_assets(request3)

puts "Got response with #{response3.assets.count} assets"
response3.assets.each do |asset|
  puts asset.inspect
end