# frozen_string_literal: true

module ::DiscourseRewind
  class RewindsController < ::ApplicationController
    requires_plugin PLUGIN_NAME

    skip_before_action :preload_json, :check_xhr, :redirect_to_login_if_required, only: %i[show]

    def show
      # expires_in 1.minute, public: false
      response.headers["X-Robots-Tag"] = "noindex"

      render "show", layout: false
    end
  end
end
