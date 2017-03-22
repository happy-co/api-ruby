require 'happyco'
require 'base64'
require 'time'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting create inspections request with client_id: #{client_id} and secret: #{client_secret}."

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

stub4 = Happyco::Inspect::Template::V1::TemplateService::Stub.new(host, credentials, timeout: 30)
request4 = Happyco::Inspect::Template::V1::ListTemplatesRequest.new(account_id: response.accounts.first.id)
response4 = stub4.list_templates(request4)

scheduled = Happyco::Inspect::Inspection::V1::ScheduledInspection.new(
  schedule_date: Happyco::Type::V1::Date.new(
    year: 2017,
    month: 07,
    day: 01
  )
)

inspection = Happyco::Inspect::Inspection::V1::Inspection.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: Time.now().to_i.to_s),
  account_id: response.accounts.first.id,
  folder_id: response2.folders.first.id,
  asset_id: response3.assets.first.id, 
  template_id: response4.templates.first.id,
  template_outline: 'no outline',
  scheduled: scheduled
)

stub5 = Happyco::Inspect::Inspection::V1::InspectionService::Stub.new(host, credentials, timeout: 30)
request5 = Happyco::Inspect::Inspection::V1::CreateInspectionsRequest.new(
  account_id: response.accounts.first.id,
  inspections: [inspection]
)
response5 = stub5.create_inspections(request5)

puts "Got response with #{response5.inspection_ids.count} inspections"
response5.inspection_ids.each do |id|
  puts "Inspection id created: #{id.inspect}"
end