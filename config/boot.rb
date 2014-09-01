# Meta-require
require_relative '../lib/utilities/require'

# Set up Bundler if Gemfile exists
ENV['BUNDLE_GEMFILE'] ||= File.expand_path '../../Gemfile', __FILE__
require 'bundler/setup' if File.exists? ENV['BUNDLE_GEMFILE']
