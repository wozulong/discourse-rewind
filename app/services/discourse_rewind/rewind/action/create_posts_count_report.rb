# frozen_string_literal: true

module DiscourseRewind
  class Rewind::Action::CreatePostsCountReport < Service::ActionBase
    option :params
    option :guardian
    option :date
    option :user

    delegate :username, :year, to: :params, private: true

    def call
      p date
      p user
      p guardian
      p username
      p year
      p params

      { data: { count: 5 }, identifier: "posts-count-report" }
    end
  end
end
