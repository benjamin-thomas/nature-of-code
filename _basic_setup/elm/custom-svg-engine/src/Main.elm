module Main exposing (main)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Html exposing (Html)
import Svg exposing (Svg)
import Svg.Attributes as Attr



-- elm-live --host 0.0.0.0 --start-page=public/index.html ./src/Main.elm -- --output=dist/main.js


circleSize : Int
circleSize =
    10


dimensions : ( Int, Int )
dimensions =
    -- Use a 16/9 ratio!
    ( 1600, 900 )


maxWidth : Int
maxWidth =
    Tuple.first dimensions


maxHeight : Int
maxHeight =
    Tuple.second dimensions


type alias Model =
    { pos : ( Float, Float )
    , dir : ( Float, Float )
    }


type Msg
    = Tick Float


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init () =
    ( { pos = ( toFloat circleSize, toFloat circleSize )
      , dir = ( 1, 1 )
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onAnimationFrameDelta Tick
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick dt ->
            let
                ( x, y ) =
                    model.pos

                speed =
                    dt / 2

                ( dirX, dirY ) =
                    model.dir

                dirX2 =
                    if x < toFloat circleSize then
                        1

                    else if x > toFloat (maxWidth - circleSize) then
                        -1

                    else
                        dirX

                dirY2 =
                    if y < toFloat circleSize then
                        1

                    else if y > toFloat (maxHeight - circleSize) then
                        -1

                    else
                        dirY
            in
            ( { model
                | pos =
                    ( x + (speed * dirX)
                    , y + (speed * dirY)
                    )
                , dir = ( dirX2, dirY2 )
              }
            , Cmd.none
            )


backGround : Svg.Svg msg
backGround =
    Svg.rect [ Attr.x "0", Attr.y "0", Attr.width "100%", Attr.height "100%" ] []


circle : String -> String -> Svg msg
circle x y =
    Svg.circle [ Attr.cx x, Attr.cy y, Attr.r (String.fromInt circleSize), Attr.fill "white" ] []


view : Model -> Html Msg
view model =
    let
        ( x, y ) =
            model.pos

        toStr =
            round >> String.fromInt
    in
    Svg.svg
        [ Attr.viewBox <| "0 0 " ++ String.fromInt maxWidth ++ " " ++ String.fromInt maxHeight
        ]
        [ backGround
        , circle (toStr x) (toStr y)
        ]


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
