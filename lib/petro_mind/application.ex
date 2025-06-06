defmodule PetroMind.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PetroMindWeb.Telemetry,
      PetroMind.Repo,
      {DNSCluster, query: Application.get_env(:petro_mind, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PetroMind.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PetroMind.Finch},
      # Start a worker by calling: PetroMind.Worker.start_link(arg)
      # {PetroMind.Worker, arg},
      # Start to serve requests, typically the last entry
      PetroMindWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetroMind.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PetroMindWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
