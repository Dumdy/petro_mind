# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PetroMind.Repo.insert!(%PetroMind.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PetroMind.Repo
alias PetroMind.Dashboard
alias PetroMind.Dashboard.Metric

metrics = [
  %{
    production_rate: 500,
    water_cut: 30,
    down_time: 2,
    average_flow_rate: 120.5,
    uptime_ratio: 0.98,
    average_pressure: 220.4
  },
  %{
    production_rate: 620,
    water_cut: 25,
    down_time: 1,
    average_flow_rate: 134.2,
    uptime_ratio: 0.99,
    average_pressure: 210.1
  },
  %{
    production_rate: 450,
    water_cut: 40,
    down_time: 4,
    average_flow_rate: 110.3,
    uptime_ratio: 0.95,
    average_pressure: 198.6
  },
  %{
    production_rate: 710,
    water_cut: 20,
    down_time: 1,
    average_flow_rate: 150.0,
    uptime_ratio: 0.997,
    average_pressure: 230.8
  },
  %{
    production_rate: 390,
    water_cut: 45,
    down_time: 6,
    average_flow_rate: 100.9,
    uptime_ratio: 0.92,
    average_pressure: 180.0
  },
  %{
    production_rate: 530,
    water_cut: 35,
    down_time: 3,
    average_flow_rate: 125.6,
    uptime_ratio: 0.96,
    average_pressure: 205.4
  },
  %{
    production_rate: 600,
    water_cut: 28,
    down_time: 2,
    average_flow_rate: 130.2,
    uptime_ratio: 0.97,
    average_pressure: 212.9
  },
  %{
    production_rate: 490,
    water_cut: 38,
    down_time: 5,
    average_flow_rate: 115.0,
    uptime_ratio: 0.93,
    average_pressure: 190.7
  },
  %{
    production_rate: 670,
    water_cut: 22,
    down_time: 1,
    average_flow_rate: 145.3,
    uptime_ratio: 0.99,
    average_pressure: 225.6
  },
  %{
    production_rate: 580,
    water_cut: 33,
    down_time: 2,
    average_flow_rate: 128.8,
    uptime_ratio: 0.96,
    average_pressure: 209.2
  },
  %{
    production_rate: 620,
    water_cut: 26,
    down_time: 1,
    average_flow_rate: 135.0,
    uptime_ratio: 0.98,
    average_pressure: 217.3
  },
  %{
    production_rate: 460,
    water_cut: 42,
    down_time: 4,
    average_flow_rate: 108.5,
    uptime_ratio: 0.94,
    average_pressure: 185.5
  },
  %{
    production_rate: 720,
    water_cut: 18,
    down_time: 0,
    average_flow_rate: 152.1,
    uptime_ratio: 1.00,
    average_pressure: 235.0
  },
  %{
    production_rate: 510,
    water_cut: 37,
    down_time: 3,
    average_flow_rate: 121.4,
    uptime_ratio: 0.95,
    average_pressure: 200.0
  },
  %{
    production_rate: 550,
    water_cut: 30,
    down_time: 2,
    average_flow_rate: 127.6,
    uptime_ratio: 0.97,
    average_pressure: 210.0
  },
  %{
    production_rate: 690,
    water_cut: 23,
    down_time: 1,
    average_flow_rate: 140.9,
    uptime_ratio: 0.99,
    average_pressure: 228.4
  },
  %{
    production_rate: 480,
    water_cut: 39,
    down_time: 5,
    average_flow_rate: 112.7,
    uptime_ratio: 0.92,
    average_pressure: 188.3
  },
  %{
    production_rate: 610,
    water_cut: 29,
    down_time: 2,
    average_flow_rate: 132.5,
    uptime_ratio: 0.96,
    average_pressure: 215.7
  },
  %{
    production_rate: 540,
    water_cut: 34,
    down_time: 3,
    average_flow_rate: 124.1,
    uptime_ratio: 0.95,
    average_pressure: 202.6
  },
  %{
    production_rate: 700,
    water_cut: 21,
    down_time: 0,
    average_flow_rate: 149.0,
    uptime_ratio: 0.995,
    average_pressure: 232.1
  }
]

Enum.each(metrics, fn attrs ->
  %Metric{}
  |> Metric.changeset(attrs)
  |> Repo.insert!()
end)

Dashboard.generate_reports_for_all_metrics()
