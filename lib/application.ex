defmodule GenHandler.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [{Task.Supervisor, name: GenHandler.TaskSupervisor}, {GenHandler.Demo, []}]

    Supervisor.start_link(
      children,
      strategy: :one_for_one,
      name: GenHandler.Supervisor
    )
  end
end
