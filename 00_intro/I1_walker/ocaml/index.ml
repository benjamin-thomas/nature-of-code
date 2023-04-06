module Canvas = P5.Canvas
module Shape = P5.Shape
module Color = P5.Color
module Sketch = P5.Sketch

type walker = { x : float; y : float }

let width = 640
let height = 360
let w = ref { x = float_of_int width /. 2.0; y = float_of_int height /. 2.0 }

let setup () =
  ()
  ; Canvas.create width height |> ignore
;;

let circle x y d = Shape.ellipse x y d d

let draw () =
  let randMov () = float_of_int @@ (Random.int 3 - 1 (* -1, 0, 1 *)) in
  ()
  ; w := { x = !w.x +. randMov (); y = !w.y +. randMov () }
  ; circle !w.x !w.y 0.1
;;

let () = Sketch.run ~setup ~draw ()
