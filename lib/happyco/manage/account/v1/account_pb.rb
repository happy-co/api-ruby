# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: happyco/manage/account/v1/account.proto

require 'google/protobuf'

require 'happyco/type/v1/integration_id_pb'
require 'happyco/type/v1/paging_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "happyco.manage.account.v1.Account" do
    optional :id, :message, 1, "happyco.type.v1.IntegrationID"
    optional :inactive, :bool, 2
    optional :name, :string, 3
    optional :phone, :string, 4
    optional :address_line_1, :string, 5
    optional :address_line_2, :string, 6
    optional :city, :string, 7
    optional :state, :string, 8
    optional :postal_code, :string, 9
    optional :country, :string, 10
  end
  add_message "happyco.manage.account.v1.ListAccountsRequest" do
    repeated :account_ids, :message, 1, "happyco.type.v1.IntegrationID"
    optional :include_inactive, :bool, 2
    optional :paging, :message, 3, "happyco.type.v1.Paging"
  end
  add_message "happyco.manage.account.v1.ListAccountsResponse" do
    repeated :accounts, :message, 1, "happyco.manage.account.v1.Account"
    optional :paging, :message, 2, "happyco.type.v1.PagingResponse"
  end
  add_message "happyco.manage.account.v1.UpdateAccountsRequest" do
    repeated :account_with_admin_ids, :message, 1, "happyco.manage.account.v1.UpdateAccountsRequest.AccountWithAdminId"
  end
  add_message "happyco.manage.account.v1.UpdateAccountsRequest.AccountWithAdminId" do
    optional :account, :message, 1, "happyco.manage.account.v1.Account"
    optional :admin_user_id, :message, 2, "happyco.type.v1.IntegrationID"
  end
  add_message "happyco.manage.account.v1.UpdateAccountsResponse" do
  end
  add_message "happyco.manage.account.v1.User" do
    optional :id, :message, 1, "happyco.type.v1.IntegrationID"
    optional :inactive, :bool, 2
    optional :first_name, :string, 3
    optional :last_name, :string, 4
    optional :email, :string, 5
    optional :phone, :string, 6
  end
  add_message "happyco.manage.account.v1.ListUsersRequest" do
    optional :account_id, :message, 1, "happyco.type.v1.IntegrationID"
    repeated :user_ids, :message, 2, "happyco.type.v1.IntegrationID"
    optional :include_inactive, :bool, 3
    optional :paging, :message, 4, "happyco.type.v1.Paging"
  end
  add_message "happyco.manage.account.v1.ListUsersResponse" do
    repeated :users, :message, 1, "happyco.manage.account.v1.User"
    optional :paging, :message, 2, "happyco.type.v1.PagingResponse"
  end
  add_message "happyco.manage.account.v1.AddUsersRequest" do
    optional :account_id, :message, 1, "happyco.type.v1.IntegrationID"
    repeated :users, :message, 2, "happyco.manage.account.v1.User"
  end
  add_message "happyco.manage.account.v1.AddUsersResponse" do
    repeated :user_ids, :message, 1, "happyco.type.v1.IntegrationID"
  end
  add_message "happyco.manage.account.v1.UpdateUsersRequest" do
    optional :account_id, :message, 1, "happyco.type.v1.IntegrationID"
    repeated :users, :message, 2, "happyco.manage.account.v1.User"
  end
  add_message "happyco.manage.account.v1.UpdateUsersResponse" do
    repeated :user_ids, :message, 1, "happyco.type.v1.IntegrationID"
  end
  add_message "happyco.manage.account.v1.UpdateUserStatusesRequest" do
    optional :account_id, :message, 1, "happyco.type.v1.IntegrationID"
    repeated :user_ids, :message, 2, "happyco.type.v1.IntegrationID"
    optional :active, :bool, 3
  end
  add_message "happyco.manage.account.v1.UpdateUserStatusesResponse" do
  end
end

module Happyco
  module Manage
    module Account
      module V1
        Account = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.Account").msgclass
        ListAccountsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.ListAccountsRequest").msgclass
        ListAccountsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.ListAccountsResponse").msgclass
        UpdateAccountsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateAccountsRequest").msgclass
        UpdateAccountsRequest::AccountWithAdminId = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateAccountsRequest.AccountWithAdminId").msgclass
        UpdateAccountsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateAccountsResponse").msgclass
        User = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.User").msgclass
        ListUsersRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.ListUsersRequest").msgclass
        ListUsersResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.ListUsersResponse").msgclass
        AddUsersRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.AddUsersRequest").msgclass
        AddUsersResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.AddUsersResponse").msgclass
        UpdateUsersRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateUsersRequest").msgclass
        UpdateUsersResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateUsersResponse").msgclass
        UpdateUserStatusesRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateUserStatusesRequest").msgclass
        UpdateUserStatusesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.manage.account.v1.UpdateUserStatusesResponse").msgclass
      end
    end
  end
end
