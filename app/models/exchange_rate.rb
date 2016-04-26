class ExchangeRate < ActiveRecord::Base
  validates_presence_of :period, :rate
  validates_uniqueness_of :period
  validates_numericality_of :rate, greater_than: 0

  def self.last_period
    order(:period).last.try(:period)
  end

  def self.rate_on(date)
    return nil unless exists?(['period >= ?', date])
    where('period <= ?', date).order(:period).last.try(:rate)
  end
end
