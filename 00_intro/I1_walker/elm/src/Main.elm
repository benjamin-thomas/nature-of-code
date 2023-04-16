module Main exposing (main)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Color
import Html exposing (Html)
import Random



{-
   elm-live --start-page=./sketch.html src/Main.elm -- --output=./dist/sketch.js
-}


type Msg
    = Frame Float
    | NextStep ( Float, Float )


type alias Model =
    { windowWidth : Int
    , windowHeight : Int
    , walker : Point
    }


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta Frame


type alias Flags =
    { width : Int, height : Int }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { windowWidth = flags.width
      , windowHeight = flags.height
      , walker =
            ( toFloat flags.width / 2
            , toFloat flags.height / 2
            )
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Frame _ ->
            ( model, Random.generate NextStep randPos )

        NextStep ( x, y ) ->
            let
                ( currX, currY ) =
                    model.walker
            in
            ( { model | walker = ( currX + (x * 3), currY + (y * 3) ) }, Cmd.none )


view : Model -> Html Msg
view model =
    Canvas.toHtml
        ( model.windowWidth, model.windowHeight )
        []
        [ shapes [ fill Color.white ] [ rect model.walker 1 1 ] ]


randPos : Random.Generator ( Float, Float )
randPos =
    Random.map2
        (\x y -> ( toFloat x, toFloat y ))
        (Random.int -1 1)
        (Random.int -1 1)
