defmodule Webhook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Periodic,
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Webhook.Endpoint,
        options: [
          dispatch: dispatch(),
          port: 3000
        ]
      ),
      Registry.child_spec(
        keys: :duplicate,
        name: Registry.Webhook
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Webhook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws/[...]", Webhook.SocketHandler, []},
         {:_, Plug.Cowboy.Handler, {Webhook.Router, []}}
       ]}
    ]
  end
end
