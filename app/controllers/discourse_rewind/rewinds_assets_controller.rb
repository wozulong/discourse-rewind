# frozen_string_literal: true

module ::DiscourseRewind
  class RewindsAssetsController < ::ApplicationController
    requires_plugin PLUGIN_NAME

    skip_before_action :preload_json, :check_xhr, only: %i[show]
    skip_before_action :verify_authenticity_token, only: %i[show]

    def show
      no_cookies

      name = params[:name]
      path, content_type =
        if name == "rewind"
          %w[rewind.css text/css]
        else
          raise Discourse::NotFound
        end

      content = File.read(DiscourseRewind.public_asset_path("css/#{path}"))

      # note, path contains a ":version" which automatically busts the cache
      # based on file content, so this is safe
      response.headers["Last-Modified"] = 10.years.ago.httpdate
      response.headers["Content-Length"] = content.bytesize.to_s
      immutable_for 1.year

      render plain: content, disposition: :nil, content_type: content_type
    end
  end
end
