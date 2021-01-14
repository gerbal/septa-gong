defmodule SeptaGong.SoundEffectRenderer do
  use Phoenix.LiveView

  alias SeptaGong.SoundEffect

  @spec render(SeptaGong.SoundEffect.t()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns = %SoundEffect{}) do
    ~L"""
    <audio autoplay=true src="<%= @file %>" id="<%= @id %>" preload=true type="audio/wav"></audio>
    """
  end
end
