defmodule GenHandler.Runner do

  def run_async_job(expect) do
    GenServer.cast(GenHandler.Demo, {:async_job, expect})
  end

  def run_sync_job(payload) do
    GenServer.call(GenHandler.Demo, {:sync_job, payload})
  end

  def run_pipeline_job(init_value) do
    GenServer.cast(GenHandler.Demo, {:stage1, %{sum: init_value}})
  end
end
