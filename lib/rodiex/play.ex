defprotocol Rodiex.Play do
  def play(source, opts)
end

defimpl Rodiex.Play, for: Float do
  def play(f, opts) do
    Rodiex.SineWave.new(f)
    |> Rodiex.play(opts)
  end
end

defimpl Rodiex.Play, for: Integer do
  def play(i, opts) do
    Rodiex.SineWave.new(i / 1)
    |> Rodiex.play(opts)
  end
end

defimpl Rodiex.Play, for: List do
  def play(sources, opts) do
    case Keyword.get(opts, :chord, true) do
      true ->
        sources
        |> Enum.map(&to_sine_wave/1)
        |> Rodiex.SineWave.play_chord(opts)

      false ->
        Enum.map(sources, &@protocol.play(&1, opts))
    end
  end

  defp to_sine_wave(%Rodiex.SineWave{} = wave), do: wave
  defp to_sine_wave(n) when is_number(n), do: Rodiex.SineWave.new(n)
end
