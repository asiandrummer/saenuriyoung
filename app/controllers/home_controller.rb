class HomeController < ApplicationController

  def index
    app_id = '534511819991113'
    app_secret = '3e9249521fe36343056a365bc99a63d4'

    @access_token = Koala::Facebook::OAuth.new(app_id, app_secret).get_app_access_token
    @graph = Koala::Facebook::API.new(@access_token)

    @groups = @graph.get_connections('164196650355754', 'feed')
    @groups.each do |group|
      if group["type"] == "photo"
        group["object"] = @graph.get_object(group["object_id"])
        group["picture_object"] = group["object"]["images"].find {|image| image["height"] > 600}
      end
    end
  end

end
