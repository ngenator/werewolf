module Werewolf
  module Roles
    class Werewolf
      include Roles

      SIDE = :evil
      VISIBLE_SIDE = SIDE
      WEIGHT = -6
      ALLIES = [Cultist]
      DESCRIPTION = "kills people at night."
    end
  end
end