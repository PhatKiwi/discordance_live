defmodule DiscordanceLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DiscordanceLiveWeb.Telemetry,
      DiscordanceLive.Repo,
      {DNSCluster, query: Application.get_env(:discordance_live, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DiscordanceLive.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DiscordanceLive.Finch},
      # Start a worker by calling: DiscordanceLive.Worker.start_link(arg)
      # {DiscordanceLive.Worker, arg},
      # Start to serve requests, typically the last entry
      DiscordanceLiveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DiscordanceLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DiscordanceLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
