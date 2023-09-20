defmodule Rodiex.Native do
  use Rustler, otp_app: :rodiex, crate: "rodiex"

  def play_sine_wave(_wave, _duration), do: nif_error()

  def play_sine_wave_chord(_waves, _duration), do: nif_error()

  defp nif_error, do: :erlang.nif_error(:nif_not_loaded)
end
