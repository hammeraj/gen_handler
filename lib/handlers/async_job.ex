defmodule GenHandler.Handlers.AsyncJob do
  use GenHandler

  @impl GenHandler
  def run(payload, _state) do
    :timer.sleep(1000)

    IO.inspect(payload)

    {:ok, :success}
  end

  @impl GenHandler
  def handle_response(response, _state) do
    IO.inspect(response)
  end
end
