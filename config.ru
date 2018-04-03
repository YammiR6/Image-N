require_relative './environment'

run Rack::URLMap.new("/" => Challenge)
