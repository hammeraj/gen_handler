defmodule GenHandler.Handlers.FailureJob do
  use GenHandler

  @impl GenHandler
  def run(_payload) do
    raise "Something Failed"
  end

  def handle_failure(failure) do
    IO.inspect(failure)
  end
end
