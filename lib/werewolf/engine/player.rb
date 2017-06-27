module Werewolf
  module Engine
    class Player
      attr_reader :name, :role

      def initialize(args)
        @alive = true
        @ready = false
        args.each { |k,v| instance_variable_set("@#{k}", v) }
      end

      def alive?
        @alive
      end

      def dead?
        !alive?
      end

      def ready?
        @ready
      end

      def ready!
        @ready = true
      end

      def assign(role)
        @role = role
      end
    end
  end
end
