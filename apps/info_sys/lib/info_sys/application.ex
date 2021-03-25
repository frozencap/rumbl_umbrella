defmodule InfoSys.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Better to stick the `restart: :permanent` in the module itself
      # New Counter worker
      # {InfoSys.Counter, 5}
      InfoSys.Cache,
      {Task.Supervisor, name: InfoSys.TaskSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InfoSys.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
