# frozen_string_literal: true

# Topics visited grouped by category
module DiscourseRewind
  module Action
    class FavoriteCategories < BaseReport
      FakeData = {
        data: [
          { category_id: 1, name: "cats" },
          { category_id: 2, name: "dogs" },
          { category_id: 3, name: "countries" },
          { category_id: 4, name: "management" },
          { category_id: 5, name: "things" },
        ],
        identifier: "favorite-categories",
      }
      def call
        return FakeData if Rails.env.development?

        favorite_categories =
          TopicViewItem
            .joins(:topic)
            .joins("INNER JOIN categories ON categories.id = topics.category_id")
            .where(user: user)
            .where(viewed_at: date)
            .where(categories: { id: user.guardian.allowed_category_ids })
            .group("categories.id, categories.name")
            .order("COUNT(*) DESC")
            .limit(5)
            .pluck("categories.id, categories.name")
            .map { |category_id, name| { category_id: category_id, name: name } }

        { data: favorite_categories, identifier: "favorite-categories" }
      end
    end
  end
end
