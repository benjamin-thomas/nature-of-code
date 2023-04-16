module Main exposing (main, update, view)

import Playground as P



{-
   elm-live ./src/Main.elm
-}


type alias Memory =
    ( P.Number, P.Number )


update : P.Computer -> Memory -> Memory
update computer ( x, y ) =
    let
        xSpeed =
            3

        moreKeyboardSpeed =
            8

        addY =
            P.toY computer.keyboard * moreKeyboardSpeed

        rightEdge =
            computer.screen.width / 2

        leftEdge =
            -rightEdge

        nextX : P.Number
        nextX =
            if x > rightEdge then
                leftEdge

            else
                x + xSpeed
    in
    ( nextX
    , y + addY
    )


view : P.Computer -> Memory -> List P.Shape
view computer ( x, y ) =
    let
        radius =
            40
    in
    [ P.rectangle P.blue computer.screen.width computer.screen.height
    , P.circle P.yellow radius |> P.move x y
    ]


main =
    let
        approxLeftEdge =
            -600
    in
    P.game view update ( approxLeftEdge, 0 )
