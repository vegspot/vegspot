require 'clockwork'
include Clockwork
require './config/boot'
require './config/environment'

every(1.hour, 'node.refresh_score') do
  Node.live.each do |node|
    node.refresh_score
  end
end