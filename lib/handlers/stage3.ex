defmodule GenHandler.Handlers.Stage3 do
  use GenHandler

  @impl GenHandler
  def run(%{sum: sum}, _state) do
    new_sum = sum + 1
    %{sum: new_sum}
  end

  @impl GenHandler
  def handle_response(response, _state), do: IO.inspect(response)
end
