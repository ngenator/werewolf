require "werewolf/engine/state"

module Werewolf
  module Engine
    class Game
      attr_reader :id, :settings, :state, :players

      def initialize(id, settings = {})
        @settings = {
          :allowed_roles => [],
          :announce_roles => true,
        }.merge(settings)
        @id = id
        reset
      end

      # Reset the game
      def reset
        @active = false
        @state = State.new
        @players = Hash.new
      end

      def active?
        @active
      end

      def join(player)
        raise PublicGameError.new("You've already joined this game.") if players.member? player.id

        @players[player.id] = player
      end

      def leave(player)
        raise PublicGameError.new("You're not in this game.") unless players.member? player.id

        @players.delete player.id
      end

      def start(player)
        raise PublicGameError.new("Game is already active.") if active?

        @owner = player
      end

      def stop(player)
        raise PublicGameError.new("Only the game owner can stop the game prematurely.") unless player.id == owner.id
      end
    end
  end
end
