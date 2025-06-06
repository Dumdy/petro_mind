defmodule PetroMind.Dashboard do
  @moduledoc """
  The Dashboard context.
  """

  import Ecto.Query, warn: false
  alias PetroMind.Repo

  alias PetroMind.Dashboard.{Chat, Metric, Report}

  @confidence_threshold 0.3

  @doc """
  Returns the list of meterics.

  ## Examples

      iex> list_meterics()
      [%Metric{}, ...]

  """
  def list_all_metrics do
    Repo.all(
      from metric in Metric,
        order_by: [desc: metric.inserted_at],
        select: %{
          id: metric.id,
          production_rate: metric.production_rate,
          water_cut: metric.water_cut,
          down_time: metric.down_time,
          average_flow_rate: metric.average_flow_rate,
          uptime_ratio: metric.uptime_ratio,
          average_pressure: metric.average_pressure,
          inserted_at: metric.inserted_at,
          updated_at: metric.updated_at
        }
    )
  end

  def list_production_rates do
    from(m in Metric, select: %{id: m.id, production_rate: m.production_rate})
    |> Repo.all()
  end

  @doc """
  Gets a single metric.

  Raises `Ecto.NoResultsError` if the Metric does not exist.

  ## Examples

      iex> get_metric!(123)
      %Metric{}

      iex> get_metric!(456)
      ** (Ecto.NoResultsError)

  """
  def get_metric!(id), do: Repo.get!(Metric, id)

  @doc """
  Creates a metric.

  ## Examples

      iex> create_metric(%{field: value})
      {:ok, %Metric{}}

      iex> create_metric(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_metric(attrs \\ %{}) do
    %Metric{}
    |> Metric.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a metric.

  ## Examples

      iex> update_metric(metric, %{field: new_value})
      {:ok, %Metric{}}

      iex> update_metric(metric, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_metric(%Metric{} = metric, attrs) do
    metric
    |> Metric.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a metric.

  ## Examples

      iex> delete_metric(metric)
      {:ok, %Metric{}}

      iex> delete_metric(metric)
      {:error, %Ecto.Changeset{}}

  """
  def delete_metric(%Metric{} = metric) do
    Repo.delete(metric)
  end

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Report{}, ...]

  """
  def list_reports do
    Repo.all(Report)
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_report!(id), do: Repo.get!(Report, id)

  def generate_reports_for_all_metrics do
    metrics = Repo.all(Metric)

    metrics
    |> Enum.flat_map(&generate_reports_from_metric/1)
    |> Enum.map(&Repo.insert!/1)
  end

  defp generate_reports_from_metric(%Metric{} = metric) do
    [
      build_report(metric, :average_flow_rate, 120.0, :>=),
      build_report(metric, :uptime_ratio, 95.0, :>=),
      build_report(metric, :water_cut, 30.0, :<),
      build_report(metric, :average_pressure, 35.0, :>=),
      build_report(metric, :down_time, 1.5, :<)
    ]
  end

  defp build_report(metric, field, threshold, comparator) do
    value = Map.get(metric, field)

    %Report{
      metric_id: metric.id,
      report_type: to_string(field) |> String.replace("_", " ") |> String.capitalize(),
      value: to_string(value),
      threshold: to_string(threshold),
      status: evaluate_status(value, threshold, comparator)
    }
  end

  defp evaluate_status(value, threshold, :>=) when is_number(value),
    do: if(value >= threshold, do: "Normal", else: "Critical")

  defp evaluate_status(value, threshold, :<=) when is_number(value),
    do: if(value <= threshold, do: "Normal", else: "Critical")

  defp evaluate_status(value, threshold, :<) when is_number(value),
    do: if(value < threshold, do: "Normal", else: "Critical")

  defp evaluate_status(value, threshold, :>) when is_number(value),
    do: if(value > threshold, do: "Normal", else: "Critical")

  defp evaluate_status(_value, _threshold, _op), do: "Unknown"

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  def analyze_input(input_text) do
    reports = Repo.all(Report)

    matches =
      reports
      |> Enum.map(fn report ->
        score = similarity_score(input_text, report.report_type)
        {report, score}
      end)
      |> Enum.filter(fn {_report, score} -> score > 0 end)
      |> Enum.sort_by(fn {_report, score} -> -score end)

    cond do
      matches == [] ->
        "❌ I couldn't find anything related to your input."

      is_question?(input_text) ->
        handle_question_input(matches)

      true ->
        handle_keyword_input(matches)
    end
  end

  defp handle_question_input([{report, score} | _]) when score >= @confidence_threshold do
    format_detailed_response(report, score)
  end

  defp handle_question_input(matches) do
    suggestions =
      matches
      |> Enum.take(3)
      |> Enum.map(fn {%{report_type: type}, score} ->
        "- #{type} (#{percent(score)}%)"
      end)
      |> Enum.join("\n")

    """
    🤔 I couldn't confidently match your question. Did you mean one of these?

    #{suggestions}
    """
  end

  defp handle_keyword_input(matches) do
    summaries =
      matches
      |> Enum.take(3)
      |> Enum.map(fn {report, score} ->
        """
        📌 #{report.report_type}
        Confidence: #{percent(score)}%
        Status: #{report.status}
        Value: #{report.value} (Threshold: #{report.threshold})
        Recorded on: #{format_datetime(report.inserted_at)}
        """
      end)
      |> Enum.join("\n\n")

    "🔍 Here are some reports related to your input:\n\n" <> summaries
  end

  defp is_question?(input) do
    String.trim(input)
    |> String.ends_with?(["?", "what", "how", "is", "are", "was", "can", "could"])
  end

  defp format_detailed_response(report, score) do
    """
    📊 **#{report.report_type}**
    Confidence: #{percent(score)}%
    Status: #{report.status}
    Value: #{report.value} (Threshold: #{report.threshold})
    Recorded on: #{format_datetime(report.inserted_at)}
    """
  end

  defp percent(score), do: Float.round(score * 100, 1)

  defp format_datetime(nil), do: "unknown"

  defp format_datetime(datetime) do
    datetime
    |> Timex.format!("%B %d, %Y at %I:%M %p %Z", :strftime)
  end

  defp similarity_score(input, report_type) do
    input = String.downcase(input)
    report = String.downcase(report_type)

    cond do
      String.contains?(input, report) -> 1.0
      true -> String.jaro_distance(input, report)
    end
  end

  @doc """
  Returns the list of chats.

  ## Examples

      iex> list_chats()
      [%Chat{}, ...]

  """
  def list_chats do
    Repo.all(Chat)
  end

  @doc """
  Gets a single chat.

  Raises `Ecto.NoResultsError` if the Chat does not exist.

  ## Examples

      iex> get_chat!(123)
      %Chat{}

      iex> get_chat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chat!(id), do: Repo.get!(Chat, id)

  @doc """
  Creates a chat.

  ## Examples

      iex> create_chat(%{field: value})
      {:ok, %Chat{}}

      iex> create_chat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chat(attrs \\ %{}) do
    %Chat{}
    |> Chat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chat.

  ## Examples

      iex> update_chat(chat, %{field: new_value})
      {:ok, %Chat{}}

      iex> update_chat(chat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chat(%Chat{} = chat, attrs) do
    chat
    |> Chat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a chat.

  ## Examples

      iex> delete_chat(chat)
      {:ok, %Chat{}}

      iex> delete_chat(chat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chat(%Chat{} = chat) do
    Repo.delete(chat)
  end
end
