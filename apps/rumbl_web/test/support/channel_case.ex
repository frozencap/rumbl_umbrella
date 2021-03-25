defmodule RumblWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import RumblWeb.ChannelCase

      # The default endpoint for testing
      @endpoint RumblWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Rumbl.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Rumbl.Repo, {:shared, self()})
    end

    :ok
  end
end
