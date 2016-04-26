namespace :exchange_rates do
  desc 'Update info about exchange rates'
  task update: :environment do
    ExchangeRateData.new.import_to_store
  end
end
