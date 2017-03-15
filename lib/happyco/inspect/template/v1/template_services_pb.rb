# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: happyco/inspect/template/v1/template.proto for package 'happyco.inspect.template.v1'

require 'grpc'
require 'happyco/inspect/template/v1/template_pb'

module Happyco
  module Inspect
    module Template
      module V1
        module TemplateService
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'happyco.inspect.template.v1.TemplateService'

            rpc :ListTemplates, ListTemplatesRequest, ListTemplatesResponse
            rpc :CreateTemplates, CreateTemplatesRequest, CreateTemplatesResponse
            rpc :UpdateTemplates, UpdateTemplatesRequest, UpdateTemplatesResponse
            rpc :ArchiveTemplates, SetTemplatesArchivedRequest, SetTemplatesArchivedResponse
            rpc :UnarchiveTemplates, SetTemplatesArchivedRequest, SetTemplatesArchivedResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
