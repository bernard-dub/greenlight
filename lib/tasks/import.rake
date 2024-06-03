namespace :import do
    desc 'Uploads data from ods'

    task :card_data, [:path] => :environment do |_t, args|
        cards_controller = CardsController.new
        cards_controller.import_data
    end
end