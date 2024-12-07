# frozen_string_literal: true

module DiscourseRewind
  class Rewind::Action::CreatePostsCountReport < Service::ActionBase
    option :params
    option :guardian

    delegate :username, :year, to: :params, private: true

    def call
      { data: { count: 5 }, identifier: "posts-count-report" }
    end
  end
end
