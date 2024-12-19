# frozen_string_literal: true

# Topics visited grouped by tag
module DiscourseRewind
  class Rewind::Action::FavoriteTags < Rewind::Action::BaseReport
    def call
      favorite_tags =
        TopicViewItem
          .joins(:topic)
          .joins("INNER JOIN topic_tags ON topic_tags.topic_id = topics.id")
          .joins("INNER JOIN tags ON tags.id = topic_tags.tag_id")
          .where(user: user)
          .where(viewed_at: date)
          .group("tags.id, tags.name")
          .order("COUNT(DISTINCT topic_views.topic_id) DESC")
          .limit(5)
          .pluck("tags.id, tags.name")
          .map { |tag_id, name| { tag_id: tag_id, name: name } }

      { data: favorite_tags, identifier: "favorite-tags" }
    end
  end
end
