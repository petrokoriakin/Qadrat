class AddExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.date :period, null: false
      t.index :period, unique: true
      t.decimal :rate, null: false

      t.timestamps null: false
    end
  end
end
