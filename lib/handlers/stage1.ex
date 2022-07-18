defmodule GenHandler.Handlers.Stage1 do
  use GenHandler

  @impl GenHandler
  def run(%{sum: sum}) do
    :timer.sleep(500)
    new_sum = sum + 1
    %{sum: new_sum}
  end
end
