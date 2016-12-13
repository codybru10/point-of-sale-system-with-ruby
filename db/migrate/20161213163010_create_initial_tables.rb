class CreateInitialTables < ActiveRecord::Migration[5.0]
  def change
    create_table(:products) do |t|
      t.column(:name, :string)
      t.column(:price, :integer)
      t.column(:purchase_id, :integer)

      t.timestamps
    end
    create_table(:purchases) do |t|
      t.column(:total, :decimal)
      t.column(:purchase_date, :timestamp)

      t.timestamps
    end
  end
end
