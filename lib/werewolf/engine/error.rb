module Werewolf
  module Engine
    class GameError < StandardError
    end

    class PublicGameError < GameError
    end

    class PrivateGameError < GameError
    end

    class InternalError < StandardError
    end
  end
end
