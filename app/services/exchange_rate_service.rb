class ExchangeRateService
  Error = Class.new(StandardError)
  NoRateDataError = Class.new(Error)
  DataRestrictionError = Class.new(Error)
  InvalidDate = Class.new(Error)
  InvalidValue = Class.new(Error)

  attr_accessor :converter, :min_year, :value, :date

  def initialize(value, date, option = {})
    self.value = BigDecimal(value)
    self.date = parse_date(date)
    self.converter = option[:converter] || ExchangeRateConverter
    self.min_year = option[:min_year] || 2000
  end

  def result
    raise DataRestrictionError if date_restricted?
    converted_val = converter.convert(value, date)
    converted_val || raise(NoRateDataError)
  end

  private

  def parse_date(str)
    Date.parse(str)
  rescue
    raise InvalidDate, "Date couldn't be parsed"
  end

  def date_restricted?
    date.year < min_year
  end
end
