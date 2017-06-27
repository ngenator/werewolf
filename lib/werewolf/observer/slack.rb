require 'slack-ruby-bot'

module Werewolf
  module Observer
    class SlackBot < SlackRubyBot::Server
      ROLE_ICONS = {
        Werewolf::Roles::Beholder => ':eyes:',
        Werewolf::Roles::Bodyguard => ':shield:',
        Werewolf::Roles::Cultist => ':dagger_knife:',
        Werewolf::Roles::Lycan => ':see_no_evil:',
        Werewolf::Roles::Seer => ':crystal_ball:',
        Werewolf::Roles::Villager => ':bust_in_silhouette:',
        Werewolf::Roles::Werewolf => ':wolf:',
      }

      # This receives notifications from a Game instance upon changes.
      # Game is Observable, and the slackbot is an observer.
      def update(options = {})
        send("handle_#{options[:action]}", options.tap { |hsh| hsh.delete(:action) })
      end

      def slackify(player)
        if player.nil?
          ''
        elsif player.bot?
          player.name
        else
          "<@#{player.name}>"
        end
      end


      private

      def tell_all(message, title: nil, color: nil, fields: nil)
        puts "tell_all('#{message}', title:'#{title}', color:'#{color}'"

        # client.say(text: message, channel: slackbot_channel)
        client.web_client.chat_postMessage(
          channel: @channel,
          as_user: true,
          attachments: [
            {
              fallback: message,
              color: color,
              title: title,
              text: message,
              fields: fields,
              mrkdwn_in: ["text", "fields"]
            }
          ]
        )
      end


      def tell_player(player, message)
        puts "tell_player(#{player.name}, #{message}")
        unless player.bot?
          dm = client.web_client.im_open(:user => "#{player.name}")
          client.say(
            text: message,
            channel: "#{dm.channel.id}",
            mrkdwn: true
          )
        end
      end


      def role_descriptions
        Werewolf::Roles::all.each_with_object({}) do |h,r|
          h[r.to_s] = {
            title: "#{ROLE_ICONS.fetch r} #{r}",
            value: "#{r.describe_team}, #{r.description}",
            short: true
          }
        end
      end


      def pluralize_votes(number)
        if number == 1
          "1 vote"
        else
          "#{number} votes"
        end
      end
    end
  end
end
