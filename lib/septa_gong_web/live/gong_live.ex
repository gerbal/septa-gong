defmodule SeptaGongWeb.GongLive do
  use SeptaGongWeb, :live_view
  alias SeptaGong.SoundEffect

  require Logger
  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    room_id = "gong:" <> room_id
    Phoenix.PubSub.subscribe(SeptaGong.PubSub, room_id)

    {:ok,
     assign(socket, sounds: [], anim_class: "", ringing: false, clear_after: 0, room_id: room_id),
     temporary_assigns: [anim_class: ""]}
  end

  @impl true
  def handle_event("gong", _, socket) do
    room_id = socket.assigns.room_id
    Phoenix.PubSub.broadcast(SeptaGong.PubSub, room_id, "gong")

    {:noreply, socket}
  end

  @impl true
  def handle_info("gong", socket) do
    Process.send_after(self(), :sound_gong, 1)

    {:noreply, assign(socket, anim_class: "", ringing: false)}
  end

  def handle_info(:sound_gong, socket) do
    Process.send_after(self(), :clear_anim, 3000)

    socket =
      socket
      |> push_event("gong", %{})
      |> assign(
        anim_class: "animate__animated animate__slower animate__fadeOut",
        ringing: true,
        clear_after: DateTime.add(DateTime.utc_now(), 3000, :millisecond)
      )

    {:noreply, socket}
  end

  def handle_info(:clear_anim, %{assigns: %{clear_after: clear_after}} = socket) do
    if DateTime.compare(DateTime.utc_now(), clear_after) == :gt do
      {:noreply, assign(socket, anim_class: "", ringing: false)}
    else
      Process.send_after(self(), :clear_anim, 500)
      {:noreply, socket}
    end
  end

end
