# frozen_string_literal: true

module DiscourseRewind
  module RewindsHelper
    # keeping it here for caching
    def self.rewind_asset_url(asset_name)
      if !%w[rewind.css].include?(asset_name)
        raise StandardError, "unknown asset type #{asset_name}"
      end

      @urls ||= {}
      url = @urls[asset_name]
      return url if url

      content = File.read(DiscourseRewind.public_asset_path("css/#{asset_name}"))
      sha1 = Digest::SHA1.hexdigest(content)
      url = "/rewinds/assets/#{sha1}/#{asset_name}"
      @urls[asset_name] = GlobalPath.cdn_path(url)
    end

    def rewind_asset_url(asset_name)
      DiscourseRewind::RewindsHelper.rewind_asset_url(asset_name)
    end
  end
end
