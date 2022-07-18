defmodule GenHandler do
  @callback run(any()) :: any()
  @callback handle_response(any()) :: any()

  defmacro __using__(_) do
    quote unquote: false do
      @behaviour GenHandler

      event = Module.split(__MODULE__) |> List.last() |> Macro.underscore |> String.to_atom()

      def event do
        unquote(event)
      end

      def run_handler(payload) do
        {unquote(event), run(payload)}
      rescue
        e ->
          handle_failure(e)
      end

      def handle_failure(failure), do: failure
      def handle_response(response), do: response
      defoverridable handle_response: 1, handle_failure: 1
    end
  end
end
