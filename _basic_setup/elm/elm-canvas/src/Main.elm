module Main exposing (main)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (circle, rect, shapes)
import Canvas.Settings exposing (fill)
import Color
import Html exposing (Html, div)
import Html.Attributes exposing (style)



-- elm-live --host 0.0.0.0 --start-page=public/index.html ./src/Main.elm -- --output=dist/main.js


circleSize : Float
circleSize =
    10


canvasHeight : Int
canvasHeight =
    600


canvasWidth : Int
canvasWidth =
    -- Always use a 16/9 ratio!
    toFloat canvasHeight * 16 / 9 |> round


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
    ( { pos = ( circleSize, circleSize )
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
                speed =
                    dt / 2

                ( x, y ) =
                    model.pos

                ( dirX, dirY ) =
                    model.dir

                ( newX, newY ) =
                    ( min (toFloat canvasWidth - circleSize) (x + (speed * dirX))
                    , min (toFloat canvasHeight - circleSize) (y + (speed * dirY))
                    )

                newDirX =
                    if newX <= circleSize then
                        1

                    else if newX >= (toFloat canvasWidth - circleSize) then
                        -1

                    else
                        dirX

                newDirY =
                    if newY <= circleSize then
                        1

                    else if newY >= (toFloat canvasHeight - circleSize) then
                        -1

                    else
                        dirY

                newModel =
                    { model
                        | pos =
                            ( newX
                            , newY
                            )
                        , dir = ( newDirX, newDirY )
                    }
            in
            ( newModel
            , Cmd.none
            )


clearScreen : Canvas.Renderable
clearScreen =
    shapes [ fill Color.white ] [ rect ( 0, 0 ) (toFloat canvasWidth) (toFloat canvasHeight) ]


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        ]
        [ Canvas.toHtml ( canvasWidth, canvasHeight )
            [ style "border" "10px solid rgba(0,0,0,0.1)"
            ]
            [ clearScreen
            , shapes [ fill Color.yellow ] [ circle model.pos circleSize ]
            ]
        ]


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
