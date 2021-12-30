defmodule Scdb.Mining.Run do
  use Ecto.Schema
  import Ecto.Changeset

  schema "runs" do
    field :captain, :string
    field :cscu, :integer
    field :location, :string
    field :miners, {:array, :string}
    field :paid_out, :boolean, default: false
    field :refinery, Ecto.Enum, values: [:"ARC-L1", :"CRU-L1", :"HUR-L1", :"HUR-L2", :"MIC-L1"]
    field :refinery_cost, :integer
    field :refining_time, :string
    field :run_time, :integer
    field :sell_price, :integer
    field :sold, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(run, attrs) do
    run
    |> cast(attrs, [:location, :refinery, :cscu, :refinery_cost, :sell_price, :captain, :miners, :run_time, :refining_time, :sold, :paid_out])
    |> validate_required([:location, :refinery, :cscu, :refinery_cost, :sell_price, :captain, :run_time, :refining_time, :sold, :paid_out])
  end
end
