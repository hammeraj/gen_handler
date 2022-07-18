defmodule GenHandlerTest do
  use ExUnit.Case
  doctest GenHandler

  test "greets the world" do
    assert GenHandler.hello() == :world
  end
end
