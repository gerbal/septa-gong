defmodule SeptaGong.SoundEffect do
  @moduledoc """
  Represents a sound file to be played.
  Sounds effects will be rendered as HTML <audio> tags.
  """

  defstruct [:file]

  @type t() :: %__MODULE__{
          file: String.t()
        }
  alias __MODULE__

  @spec new(atom()) :: t()
  def new(:gong) do
    %SoundEffect{file: "/sfx/gong.wav"}
  end
end
