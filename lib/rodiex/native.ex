defmodule Rodiex.Native do
  use Rustler, otp_app: :rodiex, crate: "rodiex"

  def play(_freq, _duration), do: nif_error()

  def play_chord(_freqs, _duration), do: nif_error()

  defp nif_error, do: :erlang.nif_error(:nif_not_loaded)
end
