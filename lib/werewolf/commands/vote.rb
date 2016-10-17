module Werewolf
  module Commands
    class Vote < SlackRubyBot::Commands::Base
      command 'vote' do |client, data, match|
        puts '**** vote ****'
        puts "client: #{client}"
        puts "data: #{data}"
        puts "data.user: #{data.user}"
        puts "match: #{match}"
        puts "match['bot']:  #{match['bot']}"
        puts "match['command']:  #{match['command']}"
        puts "match['expression']:  #{match['expression']}"        
        puts '........'

        name = Util::SlackParser.extract_username(match['expression'])
        Game.instance.vote(data.user, name)
      end
    end
  end
end