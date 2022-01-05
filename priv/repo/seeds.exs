# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Scdb.Repo.insert!(%Scdb.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

miners = ["Huey", "Dewey", "Louie"]

locations = [
  "Humboldt Mines",
  "Loveridge Mineral Reserve",
  "Shubin Mining Facility SAL-2",
  "Shubin Mining Facility SAL-5",
  "Security Depot Lyria-1",
  "Shubin Processing Facility SPAL-3",
  "Shubin Processing Facility SPAL-7",
  "Shubin Processing Facility SPAL-9",
  "Shubin Processing Facility SPAL-12",
  "Buckets",
  "Elsewhere",
  "Paradise Cove",
  "Teddy's Playhouse",
  "The Orphanage",
  "The Pit",
  "Wheeler's"
]

for _n <- 1..20 do
  # random captain and crew
  [captain | miners] = Enum.shuffle(miners)

  attrs = %{
    location: Enum.random(locations),
    refinery: Enum.random(Ecto.Enum.values(Scdb.Mining.Run, :refinery)),
    cscu: Enum.random(0..3072),
    refinery_cost: Enum.random(0..12000),
    sell_price: 88,
    run_time: Enum.random(20..55),
    refining_time: "1d 14h",
    sold: Enum.random([true, false]),
    paid_out: Enum.random([true, false]),
    captain: captain,
    miners: miners
  }

  # We have computed fields in the schema which is why we should
  # use this way to generate new entries.
  # Using Repo.insert! will leave them empty.
  %Scdb.Mining.Run{}
  |> Scdb.Mining.Run.changeset(attrs)
  |> Scdb.Repo.insert()
end
