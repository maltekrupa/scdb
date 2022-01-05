defmodule Scdb.Repo.Migrations.AddNetWorthField do
  use Ecto.Migration

  def change do
    alter table(:runs) do
      add_if_not_exists :net_worth, :integer, null: false
    end
  end
end
