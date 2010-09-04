source 'http://rubygems.org'

gem "rails", "3.0.0"

# Prevent loading of ruby-oci8 gem in JRuby
platforms :ruby do
  gem 'ruby-oci8', ">= 2.0.4"
end

# Use either latest oracle_enhanced adapter version from github
gem 'activerecord-oracle_enhanced-adapter', '~>1.3.0', :git => 'git://github.com/rsim/oracle-enhanced.git'
# Or use released gem version
# gem "activerecord-oracle_enhanced-adapter", "~>1.3.0"

# optionally also use ruby-plsql
gem "ruby-plsql", ">=0.4.3"

# group :test do
#   gem "rspec-rails", ">= 2.0.0.beta.20"
# end
