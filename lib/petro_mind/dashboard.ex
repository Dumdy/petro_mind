defmodule PetroMind.Dashboard do
  @moduledoc """
  The Dashboard context.
  """

  import Ecto.Query, warn: false
  alias PetroMind.Repo

  alias PetroMind.Dashboard.Metric

  @doc """
  Returns the list of meterics.

  ## Examples

      iex> list_meterics()
      [%Metric{}, ...]

  """
  def list_meterics do
    Repo.all(
      from metric in Metric,
        order_by: [desc: metric.inserted_at],
        select: %{
          id: metric.id,
          production_rate: metric.production_rate,
          water_cut: metric.water_cut,
          down_time: metric.down_time,
          average_flow_rate: metric.average_flow_rate,
          inserted_at: metric.inserted_at,
          updated_at: metric.updated_at
        },
        limit: 3
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
end
