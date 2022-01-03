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
    field :net_worth, :integer

    timestamps()
  end

  @doc false
  def changeset(run, attrs) do
    run
    |> cast(attrs, [:location, :refinery, :cscu, :refinery_cost, :sell_price, :captain, :miners, :run_time, :refining_time, :sold, :paid_out])
    |> validate_required([:location, :refinery, :cscu, :refinery_cost, :sell_price, :captain, :run_time, :refining_time, :sold, :paid_out])
    |> append_net_worth()
  end

  defp append_net_worth(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: run, errors: []} ->
        put_change(changeset, :net_worth, calculate_net_worth(run))
      _ ->
        put_change(changeset, :net_worth, 0)
    end
  end

  defp calculate_net_worth(run) do
    # This conditional feels wrong. Why can't the case clause in append_net_worth
    # not do the same?
    if Map.has_key?(run, :cscu) && Map.has_key?(run, :sell_price) && Map.has_key?(run, :refinery_cost) do
      run.cscu * run.sell_price - run.refinery_cost
    else
      0
    end
  end

end
