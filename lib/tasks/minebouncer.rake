namespace :minebouncer do
  desc "Removes dead games from the database"
  task dead_games: :environment do
    def is_open?(host, port)
      system("netcat -w 1 -z #{host} #{port}")
    end

    Game.all.each do |game|
      game.destroy unless is_open?(game.host, game.port)
    end
  end
end
