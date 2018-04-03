require 'rubygems'
require 'bundler'

$:.unshift File.expand_path('..', __FILE__)

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

require 'active_support/deprecation'
require 'active_support/all'
require 'challenge'
