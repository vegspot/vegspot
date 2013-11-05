class NodesWorker
  include Sidekiq::Worker

  def perform(method, *args)
    self.public_send(method, *args)
  end

  def scrap_thumbnail(node_id)
    node      = Node.find(node_id)
    thumbnail = Media::ThumbnailScrapper.new.scrap(node.url)
    node.remote_thumbnail_url = thumbnail if thumbnail
    node.save
  end

  def refresh_score(node_id)
    node = Node.find(node_id)
    shares = ShareCounts.selected node.url, [:facebook, :twitter]
    node.shares_facebook = ( shares[:facebook] || node.shares_facebook )
    node.shares_twitter  = ( shares[:twitter]  || node.shares_twitter )

    node.update_attributes(score: node.shares_facebook + node.shares_twitter + node.plusminus)
  end
end