defmodule SeptaGongWeb.GongLive do
  use SeptaGongWeb, :live_view
  alias SeptaGong.SoundEffect
  alias Phoenix.Socket.Broadcast

  require Logger
  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(SeptaGong.PubSub, "users")
    {:ok, assign(socket, sounds: [])}
  end

  @impl true
  def handle_event("gong", _, socket) do
    Phoenix.PubSub.broadcast(SeptaGong.PubSub, "users", "gong")

    {:noreply, socket}
  end

  @impl true
  def handle_info("gong", %{assigns: %{sounds: sounds}} = socket) do
    {:noreply, assign(socket, sounds: [SoundEffect.new(:gong) | sounds])}
  end
end
