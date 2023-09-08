use rodio::{
    source::{Amplify, SineWave, Source, TakeDuration},
    OutputStream, Sink,
};
use std::time::Duration;

#[rustler::nif]
fn play(freq: f32, duration: f32) {
    let (_stream, stream_handle) = OutputStream::try_default().unwrap();
    let sink = Sink::try_new(&stream_handle).unwrap();

    let sine_wave = create_sine_wave(freq, duration, 0.2);

    sink.append(sine_wave);
    sink.sleep_until_end()
}

#[rustler::nif]
fn play_chord(freqs: Vec<f32>, duration: f32) {
    let (_stream, stream_handle) = OutputStream::try_default().unwrap();

    let mut sinks = vec![];

    let amp = 0.5 / freqs.len() as f32;

    for freq in freqs {
        let sink = Sink::try_new(&stream_handle).unwrap();
        sink.append(create_sine_wave(freq, duration, amp));
        sinks.push(sink);
    }

    for sink in sinks {
        sink.sleep_until_end();
    }
}

pub(crate) fn create_sine_wave(
    freq: f32,
    duration: f32,
    amp: f32,
) -> Amplify<TakeDuration<SineWave>> {
    SineWave::new(freq)
        .take_duration(Duration::from_secs_f32(duration))
        .amplify(amp)
}

rustler::init!("Elixir.Rodiex.Native", [play, play_chord]);
