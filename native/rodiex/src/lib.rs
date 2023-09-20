use rustler::{Env, Term};

mod sine_wave;

rustler::init!(
    "Elixir.Rodiex.Native",
    [sine_wave::play_sine_wave, sine_wave::play_sine_wave_chord],
    load = on_load
);

fn on_load(env: Env, _info: Term) -> bool {
    rustler::resource!(sine_wave::SineWave, env);
    true
}
