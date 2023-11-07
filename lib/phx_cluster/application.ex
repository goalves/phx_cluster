defmodule PhxCluster.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  require Logger

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [default: [strategy: Cluster.Strategy.Gossip]]

    Logger.info("Starting application on host #{Node.self() |> inspect()}")

    children = [
      PhxClusterWeb.Telemetry,
      PhxCluster.Repo,
      {DNSCluster, query: Application.get_env(:phx_cluster, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxCluster.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxCluster.Finch},
      # Start a worker by calling: PhxCluster.Worker.start_link(arg)
      # {PhxCluster.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxClusterWeb.Endpoint,
      # Starts libcluster supervisor
      {Cluster.Supervisor, [topologies, [name: PhxCluster.ClusterSupervisor]]},
      {Task, fn -> ping_nodes() end}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxCluster.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxClusterWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp ping_nodes() do
    Process.sleep(1_000)

    Node.list()
    |> Enum.each(fn node ->
      IO.puts("[#{inspect(Node.self())} -> #{inspect(node)}] #{inspect(Node.ping(node))}")
    end)

    ping_nodes()
  end
end
