defmodule Scdb.Repo.Migrations.CreateRuns do
  use Ecto.Migration

  def change do
    create table(:runs) do
      add :location, :string
      add :refinery, :string
      add :cscu, :integer
      add :refinery_cost, :integer
      add :sell_price, :integer
      add :captain, :string
      add :miners, {:array, :string}, default: []
      add :run_time, :integer
      add :refining_time, :string
      add :sold, :boolean, default: false, null: false
      add :paid_out, :boolean, default: false, null: false

      timestamps()
    end
  end
end
