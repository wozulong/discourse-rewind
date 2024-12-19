# frozen_string_literal: true

# Topics visited grouped by category
module DiscourseRewind
  class Rewind::Action::FavoriteCategories < Rewind::Action::BaseReport
    def call
      favorite_categories =
        TopicViewItem
          .joins(:topic)
          .joins("INNER JOIN categories ON categories.id = topics.category_id")
          .where(user: user)
          .where(viewed_at: date)
          .group("categories.id, categories.name")
          .order("COUNT(*) DESC")
          .limit(5)
          .pluck("categories.id, categories.name")
          .map { |category_id, name| { category_id: category_id, name: name } }

      { data: favorite_categories, identifier: "favorite-categories" }
    end
  end
end
