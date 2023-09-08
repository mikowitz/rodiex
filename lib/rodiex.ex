defmodule Rodiex do
  alias Rodiex.Native, as: N

  def play(freq_or_freqs, opts \\ [])

  def play(freq, opts) when is_number(freq) do
    duration = Keyword.get(opts, :duration, 2.0)

    N.play(freq / 1, duration / 1)

    freq
  end

  def play(freqs, opts) when is_list(freqs) do
    duration = Keyword.get(opts, :duration, 2.0)

    freqs
    |> Enum.map(&(&1 / 1))
    |> N.play_chord(duration / 1)

    freqs
  end
end
