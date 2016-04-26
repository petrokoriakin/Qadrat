require 'csv'

class ExchangeRateData
  LOAD_LINK = "http://sdw.ecb.europa.eu/export.do?type=&trans=N&node=2018794&CURRENCY=USD&FREQ=D&start=01-01-2015&q=&submitOptions.y=6&submitOptions.x=51&sfl1=4&end=01-02-2016&SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&sfl3=4&DATASET=0&exportType=csv"

  attr_accessor :store, :parser, :http_lib, :skip_rows, :load_link, :period_column, :rate_column
  attr_reader :parsed_data

  def initialize(options = {})
    self.store = options[:store] || ExchangeRate
    self.parser ||= options[:parser] || CSV
    self.http_lib ||= options[:http_lib] || RestClient
    self.skip_rows ||= options[:skip_rows] || 5
    self.load_link ||= options[:load_link] || LOAD_LINK
    self.period_column ||= options[:period_column] || 0
    self.rate_column ||= options[:rate_column] || 1
  end

  def import_to_store
    actual_rates.each do |e|
      store.create(period: e[period_column], rate: e[rate_column])
    end
  end

  private

  def load
    parsed_data ? parsed_data : load!
  end

  def load!
    data = http_lib.get(load_link)
    @parsed_data = parser.parse(data)[skip_rows..-1]
  end

  def actual_rates
    last_period = store.last_period
    return load unless last_period
    load.select { |e| e[period_column] > last_period.to_s } if last_period
  end
end
