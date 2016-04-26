class ExchangeRateController < ApplicationController
  def index
    params[:conversion] = example_conversion_params
  end

  def convert
    begin
      service = ExchangeRateService.new(
        conversion_params[:value],
        conversion_params[:date]
      )
      @result = service.result
      params[:conversion] = parsed_conversion_params(service)
    rescue ExchangeRateService::InvalidDate
      flash.now[:notice] = t :incorrect_data
    rescue ExchangeRateService::DataRestrictionError
      flash.now[:notice] = t 'exchange_rate.date_restriction'
    rescue ExchangeRateService::NoRateDataError
      flash.now[:notice] = t 'exchange_rate.no_rate_info'
    end
    render :index
  end

  private

  def conversion_params
    params[:conversion]
  end

  def example_conversion_params
    build_conversion_params(Time.now.to_date, 100)
  end

  def parsed_conversion_params(service)
    build_conversion_params(service.date, service.value)
  end

  def build_conversion_params(date, value)
    { date: date, value: value }
  end
end
