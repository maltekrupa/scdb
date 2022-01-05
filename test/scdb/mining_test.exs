defmodule Scdb.MiningTest do
  use Scdb.DataCase

  alias Scdb.Mining

  describe "runs" do
    alias Scdb.Mining.Run

    import Scdb.MiningFixtures

    @invalid_attrs %{
      captain: nil,
      cscu: nil,
      location: nil,
      miners: nil,
      paid_out: nil,
      refinery: nil,
      refinery_cost: nil,
      refining_time: nil,
      run_time: nil,
      sell_price: nil,
      sold: nil
    }

    test "list_runs/0 returns all runs" do
      run = run_fixture()
      assert Mining.list_runs() == [run]
    end

    test "get_run!/1 returns the run with given id" do
      run = run_fixture()
      assert Mining.get_run!(run.id) == run
    end

    test "create_run/1 with valid data creates a run" do
      valid_attrs = %{
        captain: "some captain",
        cscu: 42,
        location: "some location",
        miners: [],
        paid_out: true,
        refinery: :"ARC-L1",
        refinery_cost: 42,
        refining_time: "some refining_time",
        run_time: 42,
        sell_price: 42,
        sold: true
      }

      assert {:ok, %Run{} = run} = Mining.create_run(valid_attrs)
      assert run.captain == "some captain"
      assert run.cscu == 42
      assert run.location == "some location"
      assert run.miners == []
      assert run.paid_out == true
      assert run.refinery == :"ARC-L1"
      assert run.refinery_cost == 42
      assert run.refining_time == "some refining_time"
      assert run.run_time == 42
      assert run.sell_price == 42
      assert run.sold == true
      assert run.net_worth == run.cscu * run.sell_price - run.refinery_cost
      assert run.equal_payout == trunc(run.net_worth / (length(run.miners) + 1))
    end

    test "create_run/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mining.create_run(@invalid_attrs)
    end

    test "update_run/2 with valid data updates the run" do
      run = run_fixture()

      update_attrs = %{
        captain: "some updated captain",
        cscu: 43,
        location: "some updated location",
        miners: [],
        paid_out: false,
        refinery: :"ARC-L1",
        refinery_cost: 43,
        refining_time: "some updated refining_time",
        run_time: 43,
        sell_price: 43,
        sold: false
      }

      assert {:ok, %Run{} = run} = Mining.update_run(run, update_attrs)
      assert run.captain == "some updated captain"
      assert run.cscu == 43
      assert run.location == "some updated location"
      assert run.miners == []
      assert run.paid_out == false
      assert run.refinery == :"ARC-L1"
      assert run.refinery_cost == 43
      assert run.refining_time == "some updated refining_time"
      assert run.run_time == 43
      assert run.sell_price == 43
      assert run.sold == false
      assert run.net_worth == run.cscu * run.sell_price - run.refinery_cost
      assert run.equal_payout == trunc(run.net_worth / (length(run.miners) + 1))
    end

    test "update_run/2 with invalid data returns error changeset" do
      run = run_fixture()
      assert {:error, %Ecto.Changeset{}} = Mining.update_run(run, @invalid_attrs)
      assert run == Mining.get_run!(run.id)
    end

    test "delete_run/1 deletes the run" do
      run = run_fixture()
      assert {:ok, %Run{}} = Mining.delete_run(run)
      assert_raise Ecto.NoResultsError, fn -> Mining.get_run!(run.id) end
    end

    test "change_run/1 returns a run changeset" do
      run = run_fixture()
      assert %Ecto.Changeset{} = Mining.change_run(run)
    end
  end
end
