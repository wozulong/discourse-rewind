# frozen_string_literal: true

module DiscourseRewind
  class Rewind::Action::BestTopics < Rewind::Action::BaseReport
    def call
      best_topics =
        TopTopic
          .includes(:topic)
          .references(:topic)
          .where(topic: { deleted_at: nil, created_at: date, user_id: user.id })
          .order("yearly_score DESC NULLS LAST")
          .limit(5)
          .pluck(:topic_id, :title, :excerpt, :yearly_score)
          .map do |topic_id, title, excerpt, yearly_score|
            { topic_id: topic_id, title: title, excerpt: excerpt, yearly_score: yearly_score }
          end

      { data: best_topics, identifier: "best-topics" }
    end
  end
end
