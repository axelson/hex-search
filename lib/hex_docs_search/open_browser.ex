defmodule HexDocsSearch.OpenBrowser do
  use GenServer, restart: :transient

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_opts) do
    state = %{}
    url = HexDocsSearchWeb.Endpoint.url()
    System.cmd("open", [url])
    send(self(), :shutdown)
    {:ok, state}
  end

  @impl GenServer
  def handle_info(:shutdown, state) do
    IO.puts("Shutting down!")
    {:stop, :normal, state}
  end
end
