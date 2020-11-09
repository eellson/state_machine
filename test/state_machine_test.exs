defmodule StateMachineTest do
  use ExUnit.Case
  doctest StateMachine

  test "greets the world" do
    assert StateMachine.hello() == :world
  end
end
