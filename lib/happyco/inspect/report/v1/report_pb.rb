# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: happyco/inspect/report/v1/report.proto

require 'google/protobuf'

require 'happyco/type/v1/integration_id_pb'
require 'happyco/type/v1/date_pb'
require 'happyco/type/v1/paging_pb'
require 'happyco/type/v1/event_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "happyco.inspect.report.v1.Report" do
    optional :id, :message, 1, "happyco.type.v1.IntegrationID"
    optional :public_url, :string, 2
    optional :name, :string, 3
    optional :title, :string, 4
    optional :revision, :int32, 5
    optional :account_id, :message, 6, "happyco.type.v1.IntegrationID"
    optional :folder_id, :message, 7, "happyco.type.v1.IntegrationID"
    optional :asset_id, :message, 8, "happyco.type.v1.IntegrationID"
    repeated :inspection_ids, :message, 9, "happyco.type.v1.IntegrationID"
    optional :generated_at, :message, 10, "happyco.type.v1.Date"
    optional :finalized_at, :message, 11, "happyco.type.v1.Date"
    optional :inspector_id, :message, 12, "happyco.type.v1.IntegrationID"
    optional :inspector_name, :string, 13
    optional :data, :string, 14
    map :signatories, :string, :message, 15, "happyco.inspect.report.v1.Signatory"
  end
  add_message "happyco.inspect.report.v1.Signatory" do
    optional :name, :string, 1
    optional :role, :string, 2
    optional :generated_at, :message, 3, "happyco.type.v1.Date"
    optional :signed_at, :message, 4, "happyco.type.v1.Date"
    optional :user_signed_at, :message, 5, "happyco.type.v1.Date"
  end
  add_message "happyco.inspect.report.v1.ListReportsRequest" do
    optional :account_id, :message, 1, "happyco.type.v1.IntegrationID"
    repeated :folder_ids, :message, 2, "happyco.type.v1.IntegrationID"
    repeated :asset_ids, :message, 3, "happyco.type.v1.IntegrationID"
    repeated :inspection_ids, :message, 4, "happyco.type.v1.IntegrationID"
    repeated :report_ids, :message, 5, "happyco.type.v1.IntegrationID"
    optional :archived, :bool, 6
    optional :paging, :message, 7, "happyco.type.v1.Paging"
  end
  add_message "happyco.inspect.report.v1.ListReportsResponse" do
    repeated :reports, :message, 1, "happyco.inspect.report.v1.Report"
    optional :previous_page, :message, 2, "happyco.type.v1.Paging"
    optional :next_page, :message, 3, "happyco.type.v1.Paging"
  end
  add_message "happyco.inspect.report.v1.ReportsCreatedEventRequest" do
    optional :account_id, :message, 1, "happyco.type.v1.IntegrationID"
    optional :options, :message, 2, "happyco.type.v1.EventHandlerOptions"
  end
  add_message "happyco.inspect.report.v1.ReportsCreatedEvent" do
    optional :event, :message, 1, "happyco.type.v1.Event"
    repeated :reports, :message, 2, "happyco.inspect.report.v1.ReportsCreatedEvent.ReportCreated"
  end
  add_message "happyco.inspect.report.v1.ReportsCreatedEvent.ReportCreated" do
    optional :report_id, :message, 1, "happyco.type.v1.IntegrationID"
    optional :version, :int32, 2
  end
  add_message "happyco.inspect.report.v1.ReportsCreatedEventAck" do
    optional :ack, :message, 1, "happyco.type.v1.EventAck"
  end
  add_message "happyco.inspect.report.v1.ReportsCreatedEventAckResponse" do
  end
end

module Happyco
  module Inspect
    module Report
      module V1
        Report = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.Report").msgclass
        Signatory = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.Signatory").msgclass
        ListReportsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ListReportsRequest").msgclass
        ListReportsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ListReportsResponse").msgclass
        ReportsCreatedEventRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ReportsCreatedEventRequest").msgclass
        ReportsCreatedEvent = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ReportsCreatedEvent").msgclass
        ReportsCreatedEvent::ReportCreated = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ReportsCreatedEvent.ReportCreated").msgclass
        ReportsCreatedEventAck = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ReportsCreatedEventAck").msgclass
        ReportsCreatedEventAckResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.report.v1.ReportsCreatedEventAckResponse").msgclass
      end
    end
  end
end
