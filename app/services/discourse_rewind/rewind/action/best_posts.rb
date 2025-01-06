# frozen_string_literal: true

module DiscourseRewind
  class Rewind::Action::BestPosts < Rewind::Action::BaseReport
    def call
      best_posts =
        Post
          .where(user_id: user.id)
          .where(created_at: date)
          .where(deleted_at: nil)
          .where("post_number > 1")
          .order("like_count DESC NULLS LAST")
          .limit(3)
          .pluck(:post_number, :topic_id, :like_count, :reply_count, :raw, :cooked)

      { data: best_posts, identifier: "best-posts" }
    end
  end
end
