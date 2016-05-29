module Note exposing (..)

type alias Octave = Int

type alias Velocity = Int

type Note
  = C 
  | Db
  | D
  | Eb
  | E
  | F
  | Gb
  | G
  | Ab
  | A
  | Bb
  | B

type alias NoteRepresentation =
  { octave   : Octave
  , velocity : Velocity
  , note     : Int
  }
