defmodule GenHandler.Handlers.SyncJob do
  use GenHandler

  @impl GenHandler
  def run(payload) do
    :timer.sleep(1000)

    IO.inspect(payload)

    {:ok, :success}
  end
end
