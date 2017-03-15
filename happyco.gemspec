require_relative 'version.rb'
Gem::Specification.new do |s|
  s.name = 'happyco'
  s.version = Happyco::VERSION
  s.authors = ['HappyCo Authors']
  s.email = 'devs@happy.co'
  s.homepage = 'https://github.com/happy-co/api-ruby'
  s.summary = 'Ruby client for HappyCo API'
  s.description = 'Generated from gRPC proto files' 
  s.license = 'MIT'

  s.files = %w( version.rb README.md )
  s.files += Dir.glob('lib/**/*')

  s.add_runtime_dependency 'grpc', '~> 1.1'
end
