# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: happyco/type/v1/date.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "happyco.type.v1.Date" do
    optional :year, :int32, 1
    optional :month, :int32, 2
    optional :day, :int32, 3
  end
  add_message "happyco.type.v1.DateTime" do
    optional :year, :int32, 1
    optional :month, :int32, 2
    optional :day, :int32, 3
    optional :hour24, :int32, 4
    optional :minute, :int32, 5
    optional :second, :int32, 6
  end
end

module Happyco
  module Type
    module V1
      Date = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.type.v1.Date").msgclass
      DateTime = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.type.v1.DateTime").msgclass
    end
  end
end
