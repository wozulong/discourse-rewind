# frozen_string_literal: true

DiscourseRewind::Engine.routes.draw do
  get "/rewinds" => "rewinds#show"
  get "/rewinds/assets/:version/:name" => "rewinds_assets#show"
end

Discourse::Application.routes.draw { mount ::DiscourseRewind::Engine, at: "/" }
