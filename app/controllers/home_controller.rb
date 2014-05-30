class HomeController < ApplicationController

  def index
  end

  def fb_group_feeds
    app_id = '534511819991113'
    app_secret = '3e9249521fe36343056a365bc99a63d4'

    @access_token = Koala::Facebook::OAuth.new(app_id, app_secret).get_app_access_token
    @graph = Koala::Facebook::API.new(@access_token)

    @feeds = @graph.get_connections('164196650355754', 'feed')
    @feeds.each do |feed|
      feed["person"] = @graph.get_object(feed["from"]["id"])
      feed["person"]["picture"] = @graph.get_picture(feed["from"]["id"])
      if feed["type"] == "photo"
        feed["object"] = @graph.get_object(feed["object_id"])
        feed["picture_object"] = feed["object"]["images"].find {|image| image["height"] > 600}
      end
    end

    render :layout => false
  end

end
