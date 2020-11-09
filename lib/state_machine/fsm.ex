defmodule StateMachine.FSM do
  @behaviour :gen_statem

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :temporary
    }
  end

  def start_link(foo) do
    :gen_statem.start_link(__MODULE__, foo, [])
  end

  def do_thing(server, bar) do
    IO.puts(:pre_call)

    :gen_statem.call(server, bar)

    IO.puts(:post_call)
  end

  @impl :gen_statem
  def callback_mode, do: :state_functions

  @impl :gen_statem
  def init(foo) do
    IO.puts(:init)

    {:ok, :initial, foo}
  end

  def initial({:call, from}, :bar, _foo) do
    IO.puts(:initial)

    reply = {:halt, :bar}

    # Replying here causes the caller (eg. the test) to continue - potentially
    # before termination
    {:stop_and_reply, :normal, [{:reply, from, reply}], :bar}
  end

  @impl :gen_statem
  def terminate(_reason, _state, _data) do
    IO.puts(:terminate)

    :timer.sleep(10_000)

    # This likely not called before test terminates
    IO.puts(:post_terminate_timer)
  end
end
