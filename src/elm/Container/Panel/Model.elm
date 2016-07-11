module Container.Panel.Model
    exposing
        ( FilterType(..)
        , Model
        , OscillatorWaveform(..)
        , init
        , updateOverdriveSwitch
        , updateOsc1WaveformBtn
        )

import Component.Switch as Switch
import Component.OptionPicker as OptionPicker
import Port
import Preset


type OscillatorWaveform
    = Sawtooth
    | Triangle
    | Sine
    | Square
    | Pulse
    | WhiteNoise


createOscillatorWaveform : String -> OscillatorWaveform
createOscillatorWaveform name =
    case name of
        "sawtooth" ->
            Sawtooth

        "triangle" ->
            Triangle

        "sine" ->
            Sine

        "square" ->
            Square

        "whitenoise" ->
            WhiteNoise

        _ ->
            Debug.crash <| "invalid waveform " ++ (toString name)


type FilterType
    = Lowpass
    | Highpass
    | Bandpass
    | Notch


createFilterType : String -> FilterType
createFilterType name =
    case name of
        "lowpass" ->
            Lowpass

        "highpass" ->
            Highpass

        "bandpass" ->
            Bandpass

        "notch" ->
            Notch

        _ ->
            Debug.crash <| "invalid filter type " ++ (toString name)


type alias Model =
    { osc1WaveformBtn : OptionPicker.Model OscillatorWaveform
    , overdriveSwitch : Switch.Model
    }


init : Preset.Preset -> Model
init preset =
    { overdriveSwitch =
        Switch.init preset.overdrive Port.overdrive
    , osc1WaveformBtn =
        OptionPicker.init Port.osc1Waveform
            (createOscillatorWaveform preset.oscs.osc1.waveformType)
            [ ( "sin", Sine )
            , ( "tri", Triangle )
            , ( "saw", Sawtooth )
            , ( "sqr", Square )
            ]
    }


updateOsc1WaveformBtn : OptionPicker.Model OscillatorWaveform -> Model -> Model
updateOsc1WaveformBtn btn model =
    { model | osc1WaveformBtn = btn }


updateOverdriveSwitch : Switch.Model -> Model -> Model
updateOverdriveSwitch switch model =
    { model | overdriveSwitch = switch }
