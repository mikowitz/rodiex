defmodule Rodiex.Native do
  use Rustler, otp_app: :rodiex, crate: "rodiex"

  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
