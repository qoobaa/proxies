$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "proxies"
require "minitest/autorun"
require "mocha/mini_test"

class Minitest::Test
  include Proxies
end
