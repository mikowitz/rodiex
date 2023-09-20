defmodule Rodiex.SineWave do
  defstruct [:frequency]

  def new(frequency) when is_number(frequency) and frequency > 0 do
    %__MODULE__{frequency: frequency / 1}
  end

  def play(wave, opts) do
    Rodiex.Play.play(wave, opts)
  end

  def play_chord(waves, opts) do
    duration = Keyword.get(opts, :duration, 2)
    Rodiex.Native.play_sine_wave_chord(waves, duration / 1)
    waves
  end

  defimpl Rodiex.Play do
    def play(%@for{} = wave, opts \\ []) do
      duration = Keyword.get(opts, :duration, 2)
      Rodiex.Native.play_sine_wave(wave, duration / 1)
      wave
    end
  end
end
