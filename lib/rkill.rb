require 'ps'
require "rkill/version"

module Rkill
  extend self

  attr_writer :test

  def test
    @test ||= ENV['RKILL_TEST'] || ARGV.delete('--test')
  end
end

