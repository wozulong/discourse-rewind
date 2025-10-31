# frozen_string_literal: true

# Chat usage statistics
# Shows message counts, favorite channels, DM activity, etc.
module DiscourseRewind
  module Action
    class ChatUsage < BaseReport
      def call
        return if !enabled?

        messages =
          Chat::Message.where(user_id: user.id).where(created_at: date).where(deleted_at: nil)

        total_messages = messages.count
        return if total_messages == 0

        # Get favorite channels (public channels)
        channel_usage =
          messages
            .joins(:chat_channel)
            .where(chat_channels: { type: "CategoryChannel" })
            .group("chat_channels.id", "chat_channels.name")
            .count
            .sort_by { |_, count| -count }
            .first(5)
            .map do |(id, name), count|
              { channel_id: id, channel_name: name, message_count: count }
            end

        # DM statistics
        dm_message_count =
          messages.joins(:chat_channel).where(chat_channels: { type: "DirectMessageChannel" }).count

        # Unique DM conversations
        unique_dm_channels =
          messages
            .joins(:chat_channel)
            .where(chat_channels: { type: "DirectMessageChannel" })
            .distinct
            .count(:chat_channel_id)

        # Messages with reactions received
        messages_with_reactions =
          Chat::MessageReaction
            .joins(:chat_message)
            .where(chat_messages: { user_id: user.id })
            .where(chat_messages: { created_at: date })
            .distinct
            .count(:chat_message_id)

        # Total reactions received
        total_reactions_received =
          Chat::MessageReaction
            .joins(:chat_message)
            .where(chat_messages: { user_id: user.id })
            .where(chat_messages: { created_at: date })
            .count

        # Average message length
        avg_message_length =
          messages.where("LENGTH(message) > 0").average("LENGTH(message)")&.to_f&.round(1) || 0

        {
          data: {
            total_messages: total_messages,
            favorite_channels: channel_usage,
            dm_message_count: dm_message_count,
            unique_dm_channels: unique_dm_channels,
            messages_with_reactions: messages_with_reactions,
            total_reactions_received: total_reactions_received,
            avg_message_length: avg_message_length,
          },
          identifier: "chat-usage",
        }
      end

      def enabled?
        SiteSetting.chat_enabled
      end
    end
  end
end
