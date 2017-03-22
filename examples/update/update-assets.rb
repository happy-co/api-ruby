require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting update assets request with client_id: #{client_id} and secret: #{client_secret}."

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

asset = Happyco::Manage::Asset::V1::Asset.new(
  id: response3.assets.first.id,
  archived: false,
  address_line_1: '100 Street St',
  address_line_2: 'Apt 3',
  city: 'Frisco',
  state: 'CA',
  postal_code: '94108',
  country: 'US',
  unit: Happyco::Manage::Asset::V1::Unit.new(building: '13')
)

request4 = Happyco::Manage::Asset::V1::UpdateAssetsRequest.new(
  account_id: response.accounts.first.id, 
  folder_id: response2.folders.first.id,
  assets: [asset]
)
response4 = stub3.update_assets(request4)

puts response4.inspect