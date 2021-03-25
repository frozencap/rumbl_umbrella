defmodule InfoSys.Counter do
  # `use GenServer` defines a child_spec(arg) function
  use GenServer, restart: :permanent

  # def child_spec(arg) do
  #   %{
  #     id: __MODULE__,
  #     start: { __MODULE__, :start_link, [arg]},
  #     restart: :temporary,
  #     shutdown: 5000,
  #     type: :worker
  #   }
  # end

  def inc(pid), do: GenServer.cast(pid, :inc)

  def dec(pid), do: GenServer.cast(pid, :dec)

  def val(pid) do
    GenServer.call(pid, :val)
  end

  def start_link(initial_val) do
    # invokes init
    GenServer.start_link(__MODULE__, initial_val)
  end

  def init(initial_val) do
    Process.send_after(self(), :tick, 1000)
    {:ok, initial_val}
  end

  def handle_info(:tick, val) when val <= 0, do: raise "boom!"

  def handle_info(:tick, val) do
    Process.send_after(self(), :tick, 1000)
    {:noreply, val - 1}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end
