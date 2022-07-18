defmodule GenHandler.Demo do
  use GenHandler.Handlers

  handle GenHandler.Handlers.AsyncJob, async: true
  handle GenHandler.Handlers.SyncJob
  pipeline [GenHandler.Handlers.Stage1, GenHandler.Handlers.Stage2, GenHandler.Handlers.Stage3]
end
