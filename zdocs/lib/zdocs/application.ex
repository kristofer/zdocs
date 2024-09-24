defmodule Zdocs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ZdocsWeb.Telemetry,
      Zdocs.Repo,
      {DNSCluster, query: Application.get_env(:zdocs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Zdocs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Zdocs.Finch},
      # Start a worker by calling: Zdocs.Worker.start_link(arg)
      # {Zdocs.Worker, arg},
      # Start to serve requests, typically the last entry
      ZdocsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zdocs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ZdocsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
