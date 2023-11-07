defmodule PhxCluster.Nodes do
  require Logger

  def ping_nodes() do
    Process.sleep(5_000)
    node_list = Node.list()

    Logger.info("Currently connected to #{Enum.count(node_list)} other nodes")

    Enum.each(node_list, fn node ->
      Logger.info(
        "Ping: [#{inspect(Node.self())} -> #{inspect(node)}] #{inspect(Node.ping(node))}"
      )
    end)

    ping_nodes()
  end
end
