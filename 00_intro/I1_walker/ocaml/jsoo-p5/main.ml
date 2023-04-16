module Canvas = P5.Canvas
module Shape = P5.Shape
module Color = P5.Color
module Sketch = P5.Sketch

type walker = { x : float; y : float }

let window = Brr.Window.to_jv Brr.G.window

let window_width, window_height =
  ( Jv.get window "innerWidth" |> Jv.to_int
  , Jv.get window "innerHeight" |> Jv.to_int )
;;

let width : int = window_width
let height = window_height

let walker =
  ref { x = float_of_int width /. 2.0; y = float_of_int height /. 2.0 }
;;

let square x y size = Shape.rect x y size size

(** returns one of: [-1; 0; 1] *)
let nextStep () = float_of_int @@ (Random.int 3 - 1)

let update () =
  walker := { x = !walker.x +. nextStep (); y = !walker.y +. nextStep () }
;;

(*
 * INIT
 *)
let setup () =
  Canvas.create width height |> ignore
  ; Color.background (Color.make 0 0 0)
  ; Color.stroke (Color.make 255 255 255)
;;

let draw () =
  let size = 0.01 in
  update ()
  ; square !walker.x !walker.y size
;;

let () = Sketch.run ~setup ~draw ()
