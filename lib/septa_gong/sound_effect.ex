defmodule SeptaGong.SoundEffect do
  @moduledoc """
  Represents a sound file to be played.
  Sounds effects will be rendered as HTML <audio> tags.
  """

  defstruct [:file, :duration, :playback_finished, :id]

  @type t() :: %__MODULE__{
          file: String.t(),
          duration: integer(),
          playback_finished: integer() | nil,
          id: String.t()
        }
  alias __MODULE__

  @spec new(atom()) :: t()
  def new(:gong) do
    %SoundEffect{file: "/sfx/gong.wav", duration: 15830}
    |> set_id()
    |> set_finished_time()
  end

  def new(:voice) do
    %SoundEffect{file: "/sfx/voice.wav", duration: 2000}
    |> set_id()
    |> set_finished_time()
  end

  defp id(length \\ 16) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  defp set_id(%SoundEffect{} = sound) do
    Map.put(sound, :id, id())
  end

  defp set_finished_time(%SoundEffect{duration: duration} = sound) do
    Map.put(sound, :playback_finished, DateTime.add(DateTime.utc_now(), duration, :millisecond))
  end
end
