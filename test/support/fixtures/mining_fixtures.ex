defmodule Scdb.MiningFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scdb.Mining` context.
  """

  @doc """
  Generate a run.
  """
  def run_fixture(attrs \\ %{}) do
    {:ok, run} =
      attrs
      |> Enum.into(%{
        captain: "some captain",
        cscu: 42,
        location: "some location",
        miners: [],
        paid_out: true,
        refinery: :test_refinery,
        refinery_cost: 42,
        refining_time: "some refining_time",
        run_time: 42,
        sell_price: 42,
        sold: true
      })
      |> Scdb.Mining.create_run()

    run
  end
end
