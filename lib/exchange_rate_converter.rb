class ExchangeRateConverter
  class << self
    attr_writer :rate_store

    def convert(val, date)
      rate = rate_store.rate_on(date)
      return nil unless rate
      val / rate
    end

    def rate_store
      @rate_store || ExchangeRate
    end
  end
end
