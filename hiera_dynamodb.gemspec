Gem::Specification.new do |s|
  s.name    = %q{hiera_dynamodb}
  s.version = "0.0.1"
  s.date    = %q{2019-06-13}
  s.summary = %q{Use AWS DynamoDB has a hiera backend}
  s.author  = "Andy Brown"
  s.email   = 'andy@techdad.tech'
  s.homepage = 'http://github.com/andytechdad/hiera-dynamodb'
  s.files   = [
    "lib/hiera/backend/dynamodb_backend.rb"
  ]
  s.require_paths = ["lib"]
  s.add_development_dependency "hiera"
  s.add_development_dependency "aws-sdk-dynamodb"
  s.add_development_dependency "rspec"
end
