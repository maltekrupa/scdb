defmodule ScdbWeb.RunLiveTest do
  use ScdbWeb.ConnCase

  import Phoenix.LiveViewTest
  import Scdb.MiningFixtures

  @create_attrs %{
    captain: "some captain",
    cscu: 42,
    location: "some location",
    miners: "one",
    paid_out: true,
    refinery: "ARC-L1",
    refinery_cost: 42,
    refining_time: "some refining_time",
    run_time: 42,
    sell_price: 42,
    sold: true
  }
  @update_attrs %{
    captain: "some updated captain",
    cscu: 43,
    location: "some updated location",
    miners: "one, two",
    paid_out: false,
    refinery: "HUR-L2",
    refinery_cost: 43,
    refining_time: "some updated refining_time",
    run_time: 43,
    sell_price: 43,
    sold: false
  }
  @invalid_attrs %{
    captain: nil,
    cscu: nil,
    location: nil,
    miners: nil,
    paid_out: false,
    refinery: nil,
    refinery_cost: nil,
    refining_time: nil,
    run_time: nil,
    sell_price: nil,
    sold: false
  }

  defp create_run(_) do
    run = run_fixture()
    %{run: run}
  end

  describe "Index" do
    setup [:create_run]

    test "lists all runs", %{conn: conn, run: run} do
      {:ok, _index_live, html} = live(conn, Routes.run_index_path(conn, :index))

      assert html =~ "Listing Runs"
      assert html =~ run.captain
    end

    test "saves new run", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.run_index_path(conn, :index))

      assert index_live |> element("a", "New Run") |> render_click() =~
               "New Run"

      assert_patch(index_live, Routes.run_index_path(conn, :new))

      assert index_live
             |> form("#run-form", run: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#run-form", run: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.run_index_path(conn, :index))

      assert html =~ "Run created successfully"
      assert html =~ "some captain"
    end

    test "updates run in listing", %{conn: conn, run: run} do
      {:ok, index_live, _html} = live(conn, Routes.run_index_path(conn, :index))

      assert index_live |> element("#run-#{run.id} a", "Edit") |> render_click() =~
               "Edit Run"

      assert_patch(index_live, Routes.run_index_path(conn, :edit, run))

      assert index_live
             |> form("#run-form", run: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#run-form", run: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.run_index_path(conn, :index))

      assert html =~ "Run updated successfully"
      assert html =~ "some updated captain"
    end

    test "deletes run in listing", %{conn: conn, run: run} do
      {:ok, index_live, _html} = live(conn, Routes.run_index_path(conn, :index))

      assert index_live |> element("#run-#{run.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#run-#{run.id}")
    end
  end

  describe "Show" do
    setup [:create_run]

    test "displays run", %{conn: conn, run: run} do
      {:ok, _show_live, html} = live(conn, Routes.run_show_path(conn, :show, run))

      assert html =~ "Show Run"
      assert html =~ run.captain
    end

    test "updates run within modal", %{conn: conn, run: run} do
      {:ok, show_live, _html} = live(conn, Routes.run_show_path(conn, :show, run))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Run"

      assert_patch(show_live, Routes.run_show_path(conn, :edit, run))

      assert show_live
             |> form("#run-form", run: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#run-form", run: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.run_show_path(conn, :show, run))

      assert html =~ "Run updated successfully"
      assert html =~ "some updated captain"
    end
  end
end
