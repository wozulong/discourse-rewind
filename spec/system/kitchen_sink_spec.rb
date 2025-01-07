# frozen_string_literal: true

describe "Discourse Rewind - kitchen sink", type: :system do
  fab!(:current_user) { Fabricate(:user) }

  before do
    SiteSetting.discourse_reactions_enabled = true
    SiteSetting.chat_enabled = true
    SiteSetting.discourse_rewind_enabled = true

    sign_in(current_user)

    # reactions received
    reactions = %w[open_mouth confetti_ball hugs +1 laughing heart]
    Fabricate
      .times(10, :post, user: current_user)
      .each do |post|
        DiscourseReactions::Reaction.create!(
          created_at: (Date.new(2024, 1, 1) + rand(1..200).days),
          post:,
          reaction_value: reactions.sample,
        )
      end

    # reading time
    100.times do |i|
      UserVisit.create!(
        user_id: current_user.id,
        time_read: rand(1..200),
        visited_at: (Date.new(2024, 1, 1) + i.days).strftime("%Y-%m-%d"),
      )
    end

    # calendar
    Fabricate.times(10, :post, user: current_user, created_at: Date.new(2024, 1, 25))
    Fabricate.times(1, :post, user: current_user, created_at: Date.new(2024, 3, 12))
    Fabricate.times(5, :post, user: current_user, created_at: Date.new(2024, 8, 19))
    Fabricate.times(1, :post, user: current_user, created_at: Date.new(2024, 10, 29))
    Fabricate.times(20, :post, user: current_user, created_at: Date.new(2024, 11, 2))
  end

  it "can visit the rewind page" do
    visit("/my/activity/rewind")

    pause_test
  end
end
