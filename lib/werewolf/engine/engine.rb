require 'singleton'

require 'werewolf/engine/game'

module Werewolf
  module Engine
    class Engine
      include Singleton

      attr_reader :games

      def initialize
        @games = Hash.new
      end

      def add(game)
        # TODO: do something when a game already exists
        if @games.member? game.id
          raise PublicGameError.new("A game already exists!")
        else
          @games[game.id] = game
        end
      end
    end
  end
end
