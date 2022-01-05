defmodule Scdb.Repo.Migrations.AddEqualPayoutField do
  use Ecto.Migration

  def change do
    alter table(:runs) do
      add_if_not_exists :equal_payout, :integer, null: false
    end
  end
end
