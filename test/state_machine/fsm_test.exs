defmodule StateMachine.FSMTest do
  use ExUnit.Case

  alias StateMachine.FSM

  setup do
    statem = start_supervised!(FSM)

    %{statem: statem}
  end

  test "foo", %{statem: statem} do
    IO.puts(:test_begin)

    FSM.do_thing(statem, :bar)

    IO.puts(:test_end)
  end
end
