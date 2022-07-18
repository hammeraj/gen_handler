defmodule GenHandler.Handlers.FailureJob do
  use GenHandler

  @impl GenHandler
  def run(_payload, _state) do
    raise "Something Failed"
  end

  def handle_failure(failure, _state) do
    IO.inspect(failure)
  end
end
