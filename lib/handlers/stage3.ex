defmodule GenHandler.Handlers.Stage3 do
  use GenHandler

  @impl GenHandler
  def run(%{sum: sum}) do
    new_sum = sum + 1
    %{sum: new_sum}
  end

  @impl GenHandler
  def handle_response(response), do: IO.inspect(response)
end
