require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting create assets request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Manage::Folder::V1::FolderService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Folder::V1::ListFoldersRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_folders(request2)

asset = Happyco::Manage::Asset::V1::Asset.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: Time.now().to_i.to_s),
  archived: false,
  address_line_1: '830 Street St',
  address_line_2: 'Apt 333',
  city: 'San Francisco',
  state: 'CA',
  postal_code: '94109',
  country: 'USA',
  unit: Happyco::Manage::Asset::V1::Unit.new(building: '138')
)

stub3 = Happyco::Manage::Asset::V1::AssetService::Stub.new(host, credentials, timeout: 30)
request3 = Happyco::Manage::Asset::V1::CreateAssetsRequest.new(
  account_id: response.accounts.first.id, 
  folder_id: response2.folders.first.id,
  assets: [asset]
)
response3 = stub3.create_assets(request3)

puts "Got response with #{response3.asset_ids.count} assets"
response3.asset_ids.each do |id|
  puts "Asset id created: #{id.inspect}"
end