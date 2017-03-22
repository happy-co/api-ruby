require 'happyco'
require 'base64'

client_id = ARGV[0] || ENV['HAPPYCO_CLIENT_ID']
client_secret = ARGV[1] || ENV['HAPPYCO_CLIENT_SECRET']
host = ENV['API_HOST'] || 'grpc.happyco.com'

auth = "Basic #{Base64.encode64("#{client_id}:#{client_secret}").strip}"
auth_proc = proc { { 'authorization' => auth }}

puts "Attempting create templates request with client_id: #{client_id} and secret: #{client_secret}."

call_credentials = GRPC::Core::CallCredentials.new auth_proc
channel_credentials = GRPC::Core::ChannelCredentials.new
credentials = channel_credentials.compose(call_credentials)

stub = Happyco::Manage::Account::V1::AccountService::Stub.new(host, credentials, timeout: 30)
request = Happyco::Manage::Account::V1::ListAccountsRequest.new()
response = stub.list_accounts(request)

stub2 = Happyco::Manage::Folder::V1::FolderService::Stub.new(host, credentials, timeout: 30)
request2 = Happyco::Manage::Folder::V1::ListFoldersRequest.new(account_id: response.accounts.first.id)
response2 = stub2.list_folders(request2)

template = Happyco::Inspect::Template::V1::Template.new(
  id: Happyco::Type::V1::IntegrationID.new(external_id: Time.now().to_i.to_s),
  account_id: response.accounts.first.id,
  folder_id: response2.folders.first.id,
  name: 'Brittneys New Test Template',
  edition: 1,
  description: 'API test template creation'
)

stub3 = Happyco::Inspect::Template::V1::TemplateService::Stub.new(host, credentials, timeout: 30)
request3 = Happyco::Inspect::Template::V1::CreateTemplatesRequest.new(
  account_id: response.accounts.first.id,
  folder_id: response2.folders.first.id,
  templates: [template]
)
response3 = stub3.create_templates(request3)

puts "Got response with #{response3.template_ids.count} templates"
response3.template_ids.each do |id|
  puts "Template id created: #{id.inspect}"
end