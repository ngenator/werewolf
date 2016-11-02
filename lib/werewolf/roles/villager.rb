module Werewolf
  module Roles
    class Villager
      include Roles

      SIDE = :good
      VISIBLE_SIDE = SIDE
      WEIGHT = 1
      ALLIES = []
      DESCRIPTION = "no special powers."
    end
  end
end
