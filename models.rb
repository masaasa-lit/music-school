require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection('sqlite3:db/development.db')
end

class History < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_secure_password
end