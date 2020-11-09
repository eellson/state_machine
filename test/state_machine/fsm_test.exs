defmodule StateMachine.FSMTest do
  use ExUnit.Case

  alias StateMachine.FSM

  setup do
    statem = start_supervised!(FSM)

    %{statem: statem}
  end

  test "foo", %{statem: statem} do
    IO.puts(:test_begin)

    # Let's monitor the state maching
    Process.monitor(statem)

    FSM.do_thing(statem, :bar)

    receive do
      msg -> IO.inspect(msg)
    end

    IO.puts(:test_end)
  end
end
