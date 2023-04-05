module Canvas = P5.Canvas
module Shape = P5.Shape
module Color = P5.Color
module Sketch = P5.Sketch

let setup () =
  ()
  ; Canvas.create 640 360 |> ignore
;;

let circle x y d = Shape.ellipse x y d d

let draw () =
  ()
  ; Color.stroke (Color.make 0 0 0) (* borders black *)
  ; Color.fill (Color.make 255 0 0)
  ; circle 100. 100. 50.
;;

let () = Sketch.run ~setup ~draw ()
