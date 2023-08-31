defmodule Rodiex do
  alias Rodiex.Native, as: N

  def play(freq, opts \\ []) when is_number(freq) do
    duration = Keyword.get(opts, :duration, 2.0)

    N.play(freq / 1, duration / 1)

    freq
  end

  def play_chord(freqs, opts \\ []) when is_list(freqs) do
    duration = Keyword.get(opts, :duration, 2.0)

    freqs
    |> Enum.map(&(&1 / 1))
    |> N.play_chord(duration / 1)

    freqs
  end
end
