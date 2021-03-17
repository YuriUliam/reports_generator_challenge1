defmodule ReportsGeneratorChallenge1 do
  alias ReportsGeneratorChallenge1.Parser

  @names [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  defp sum_values([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month =
      Map.put(hours_per_month, name, put_value(hours_per_month[name], month, hours))

    hours_per_year = Map.put(hours_per_year, name, put_value(hours_per_year[name], year, hours))

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp put_value(map, key, value) do
    Map.put(map, key, map[key] + value)
  end

  defp report_acc do
    months = Enum.into(1..12, %{}, &{&1, 0})
    years = Enum.into(2016..2020, %{}, &{&1, 0})

    all_hours = Enum.into(@names, %{}, &{&1, 0})
    hours_per_month = Enum.into(@names, %{}, &{&1, months})
    hours_per_year = Enum.into(@names, %{}, &{&1, years})

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
