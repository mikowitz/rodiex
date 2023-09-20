use rodio::{source::Source, OutputStream, Sink};
use std::time::Duration;

#[derive(rustler::NifStruct)]
#[module = "Rodiex.SineWave"]
pub struct SineWave {
    pub frequency: f32,
}

#[rustler::nif]
pub fn play_sine_wave(wave: SineWave, duration: f32) {
    let wave = rodio::source::SineWave::new(wave.frequency)
        .take_duration(Duration::from_secs_f32(duration))
        .amplify(0.1);

    let (_stream, stream_handle) = OutputStream::try_default().unwrap();
    let sink = Sink::try_new(&stream_handle).unwrap();

    sink.append(wave);
    sink.sleep_until_end()
}

#[rustler::nif]
pub fn play_sine_wave_chord(waves: Vec<SineWave>, duration: f32) {
    let (_stream, stream_handle) = OutputStream::try_default().unwrap();

    let mut sinks = vec![];

    let amp = 0.5 / waves.len() as f32;

    for wave in waves {
        let sink = Sink::try_new(&stream_handle).unwrap();
        let wave = rodio::source::SineWave::new(wave.frequency)
            .take_duration(Duration::from_secs_f32(duration))
            .amplify(amp);
        sink.append(wave);
        sinks.push(sink);
    }

    for sink in sinks {
        sink.sleep_until_end();
    }
}
