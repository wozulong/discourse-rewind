# frozen_string_literal: true

module DiscourseRewind
  # Service responsible to fetch a rewind for a username/year.
  #
  # @example
  #  ::DiscourseRewind::Rewind::Fetch.call(
  #    guardian: guardian,
  #    params: {
  #      username: "falco",
  #      year: 2024,
  #    }
  #  )
  #
  class Rewind::Fetch
    include Service::Base

    # @!method self.call(guardian:, params:)
    #   @param [Guardian] guardian
    #   @param [Hash] params
    #   @option params [Integer] :year of the rewind
    #   @option params [Integer] :username of the rewind
    #   @return [Service::Base::Context]

    # order matters, rewinds are displayed in the order they are defined
    REPORTS = [DiscourseRewind::Rewind::Action::CreatePostsCountReport]

    CACHE_DURATION = 5.minutes

    params do
      attribute :year, :integer
      attribute :username, :string

      validates :year, presence: true
      validates :username, presence: true
    end

    model :reports

    private

    def fetch_reports(params:, guardian:)
      key = "rewind:#{params.username}:#{params.year}"
      reports = Discourse.redis.get(key)

      if Rails.env.development? || !reports
        reports = REPORTS.map { |report| report.call(params:, guardian:) }
        Discourse.redis.setex(key, CACHE_DURATION, MultiJson.dump(reports))
      else
        reports = MultiJson.load(reports)
      end

      reports
    end
  end
end
