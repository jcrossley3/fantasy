ADP_URL = 'http://fantasyfootballcalculator.com/adp_xml.php?teams=12'

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'ostruct'
require 'tiers'

doc = Nokogiri::XML(open(ADP_URL))

players = (doc/'player').map do |player|
  adp, name, pos, team = (player%'adp').text, (player%'name').text, (player%'pos').text, (player%'team').text
  OpenStruct.new :adp => adp, :name => name, :pos => pos, :team => team, :tier => TIERS[name]
end

if ARGV[0] == '-t'
  players = players.select {|p| p.pos == ARGV[1]} if ARGV[1]
  players = players.reject {|p| p.tier.nil?}.sort_by { |p| format("%3s %2s %5s", p.pos, p.tier, p.adp) }
end

players.each do |p|
  puts format("%5s  %-25s %3s  %3s  %2s", p.adp, p.name, p.team, p.pos, p.tier)
end

