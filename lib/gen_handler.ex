defmodule GenHandler do
  @callback run(any(), any()) :: any()
  @callback handle_response(any(), any()) :: any()
  @callback handle_failure(any(), any()) :: any()

  defmacro __using__(_) do
    quote unquote: false do
      @behaviour GenHandler

      event = Module.split(__MODULE__) |> List.last() |> Macro.underscore |> String.to_atom()

      def event do
        unquote(event)
      end

      def run_handler(payload, state) do
        {unquote(event), run(payload, state)}
      rescue
        e ->
          handle_failure(e, state)
      end

      def handle_failure(failure, _state), do: failure
      def handle_response(response, _state), do: response
      defoverridable handle_response: 2, handle_failure: 2
    end
  end
end
