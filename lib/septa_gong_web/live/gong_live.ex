defmodule SeptaGongWeb.GongLive do
  use SeptaGongWeb, :live_view
  alias SeptaGong.SoundEffect

  require Logger
  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(SeptaGong.PubSub, "users")
    {:ok, assign(socket, sounds: [], button_class: "", ringing: false), temporary_assigns: [button_class: ""]}
  end

  @impl true
  def handle_event("gong", _, socket) do
    Phoenix.PubSub.broadcast(SeptaGong.PubSub, "users", "gong")

    {:noreply, socket}
  end

  @impl true
  def handle_info("gong", %{assigns: %{sounds: sounds}} = socket) do
    Process.send_after(self(), :clear_anim, 750)

    {:noreply,
     assign(socket,
       sounds: [SoundEffect.new(:gong) | sounds],
       button_class: "animate__animated animate__fadeOut",
       ringing: true
     )}
  end

  def handle_info(:clear_anim, socket) do
    {:noreply, assign(socket, button_class: "", ringing: false  )}
  end

end
