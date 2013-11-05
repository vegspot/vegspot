require 'clockwork'
include Clockwork
require './config/boot'
require './config/environment'

every(3.hour, 'node.refresh_score', at: '**:00') do
  Node.live.this_month.each do |node|
    NodesWorker.perform_async(:refresh_score, node.id)
  end
end