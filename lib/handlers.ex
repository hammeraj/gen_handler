defmodule GenHandler.Handlers do
  defmacro __using__(_) do
    quote do
      use GenServer
      import GenHandler.Handlers

      def start_link(opts) do
        GenServer.start_link(__MODULE__, opts, name: __MODULE__)
      end

      def init(init_arg) do
        {:ok, init_arg}
      end

      def handle_info({:DOWN, _ref, :process, _pid, _reason}, state) do
        IO.inspect("Task failed")
        {:noreply, state}
      end

      defoverrideable start_link: 1, init: 1
    end
  end

  defmacro handle(module, async: true) do
    quote unquote: false, bind_quoted: [module: module] do
      event = module.event

      def handle_cast({unquote(event), payload}, state) do
        Task.Supervisor.async_nolink(GenHandler.TaskSupervisor, unquote(module), :run_handler, [payload, state])
        {:noreply, state}
      end

      def handle_info({ref, {unquote(event), response}}, state) do
        Process.demonitor(ref, [:flush])
        unquote(module).handle_response(response, state)
        {:noreply, state}
      end
    end
  end

  defmacro handle(module) do
    quote unquote: false, bind_quoted: [module: module] do
      event = module.event

      def handle_call({unquote(event), payload}, _from, state) do
        response = unquote(module).run(payload, state)
        unquote(module).handle_response(response, state)
        {:reply, results, state}
      end
    end
  end

  defmacro pipeline(modules) do
    quote location: :keep,
      unquote: false,
      bind_quoted: [
        modules: modules
      ],
      generated: true do
        Enum.with_index(modules, fn module, index ->
          next_module = Enum.at(modules, index + 1)
          event = module.event
          next_event = case next_module do
            nil -> nil
            exists -> exists.event
          end

          def handle_cast({unquote(event), payload}, state) do
            Task.Supervisor.async_nolink(GenHandler.TaskSupervisor, unquote(module), :run_handler, [payload, state])
            {:noreply, state}
          end

          def handle_info({ref, {unquote(event), response}}, state) do
            Process.demonitor(ref, [:flush])
            handled_response = unquote(module).handle_response(response, state)
            if unquote(next_event), do: GenServer.cast(__MODULE__, {unquote(next_event), handled_response})
            {:noreply, state}
          end
        end)
    end
  end
end
