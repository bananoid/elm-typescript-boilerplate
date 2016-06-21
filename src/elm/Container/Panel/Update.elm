module Container.Panel.Update exposing (..)

--where

import Container.Panel.Model as Model exposing (..)
import Component.Knob as Knob
import Component.NordButton as Button
import Dict exposing (..)


type Msg
    = Oscillator1WaveformChange Button.Msg
    | Oscillator2WaveformChange Button.Msg
    | FilterTypeChange Button.Msg
    | KnobMsg Knob.Msg


--TODO: put buttons inside dicts
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        updateMap childUpdate childMsg getChild reduxor msg' =
            let
                ( updatedChildModel, childCmd ) =
                    childUpdate childMsg (getChild model)
            in
                ( reduxor updatedChildModel model
                , Cmd.map msg' childCmd
                )

        updateKnobs : Knob.Msg -> Msg -> ( Model, Cmd Msg )
        updateKnobs knobMsg msg' =
            let
                ( knobNames, knobModels ) =
                    List.unzip <| Dict.toList model.knobs

                ( knobModels', cmds ) =
                    List.unzip
                        <| List.map
                            --(Knob.update << knobMsg)
                            (\knob -> Knob.update knobMsg knob)
                            knobModels

                knobs =
                    Dict.fromList
                        <| List.map2 (,) knobNames knobModels'
            in
                ( { model | knobs = knobs }
                , Cmd.map (always msg') <| Cmd.batch cmds
                )
    in
        case msg of
            Oscillator1WaveformChange subMsg ->
                updateMap Button.update
                    subMsg
                    .oscillator1WaveformBtn
                    updateOscillator1WaveformBtn
                    Oscillator1WaveformChange

            Oscillator2WaveformChange subMsg ->
                updateMap Button.update
                    subMsg
                    .oscillator2WaveformBtn
                    updateOscillator2WaveformBtn
                    Oscillator2WaveformChange

            FilterTypeChange subMsg ->
                updateMap Button.update
                    subMsg
                    .filterTypeBtn
                    updateFilterTypeBtn
                    FilterTypeChange

            KnobMsg subMsg ->
                updateKnobs subMsg (KnobMsg subMsg)
 