# while this request appears to work — gets a response and sends successful change to changes event - the db does not update - fix coming soon

require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting update inspections request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub1 = Happyco::Inspect::Inspection::V1::InspectionService::Stub.new(host, credentials, timeout: 30)
request1 = Happyco::Inspect::Inspection::V1::ListInspectionsRequest.new(account_id: response.accounts.first.id)
response1 = stub1.list_inspections(request1)

stub2 = Happyco::Manage::Folder::V1::FolderService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Folder::V1::ListFoldersRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_folders(request2)

stub3 = Happyco::Manage::Asset::V1::AssetService::Stub.new(host, credentials, timeout: 30)
request3 = Happyco::Manage::Asset::V1::ListAssetsRequest.new(
  account_id: response.accounts.first.id, 
  folder_id: response2.folders.first.id
)
response3 = stub3.list_assets(request3)

stub4 = Happyco::Inspect::Template::V1::TemplateService::Stub.new(host, credentials, timeout: 30)
request4 = Happyco::Inspect::Template::V1::ListTemplatesRequest.new(account_id: response.accounts.first.id)
response4 = stub4.list_templates(request4)

date = Happyco::Type::V1::Date.new(year: 2017, month: 07, day: 01)

completed_data = Happyco::Inspect::Inspection::V1::InspectionData.new(
  started_at: date,
  ended_at: date,
  user_started_at: date,
  user_ended_at: date
)

inspection = Happyco::Inspect::Inspection::V1::Inspection.new(
  id: response1.inspections.first.id,
  account_id: response.accounts.first.id,
  folder_id: response2.folders.first.id,
  asset_id: response3.assets.first.id, 
  template_id: response4.templates.first.id,
  template_outline: 'edited outline',
  completed: completed_data
)

request5 = Happyco::Inspect::Inspection::V1::UpdateInspectionsRequest.new(
  account_id: response.accounts.first.id,
  inspections: [inspection]
)
response5 = stub1.update_inspections(request5)

puts response5.inspect