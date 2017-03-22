require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting update templates request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Manage::Folder::V1::FolderService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Folder::V1::ListFoldersRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_folders(request2)

stub3 = Happyco::Inspect::Template::V1::TemplateService::Stub.new(host, credentials, timeout: 30)
request3 = Happyco::Inspect::Template::V1::ListTemplatesRequest.new(account_id: response.accounts.first.id)
response3 = stub3.list_templates(request2)

template = Happyco::Inspect::Template::V1::Template.new(
  id: response3.templates.first.id,
  account_id: response.accounts.first.id,
  folder_id: response2.folders.first.id,
  name: 'Brittneys Edited Template',
  edition: 1,
  description: 'API test template update'
)

request4 = Happyco::Inspect::Template::V1::UpdateTemplatesRequest.new(
  account_id: response.accounts.first.id,
  folder_id: response2.folders.first.id,
  templates: [template]
)
response4 = stub3.update_templates(request4)

puts response4.inspect