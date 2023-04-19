(*
   dune utop
   > Sketch.center_x
 *)

module R = Raylib
module Color = R.Color

(*
 * WINDOW
 *)
let width = 640
let height = 360

let setup () =
  ()
  ; R.set_config_flags [ R.ConfigFlags.Msaa_4x_hint ]
  ; R.set_target_fps 60
  ; R.init_window width height "OCaml/Raylib: Random walker"
;;

let half_or_raise n err =
  let half = n / 2 in
  if half * 2 = n then
    half
  else
    raise @@ Invalid_argument err
;;

let center_x = half_or_raise width "center_x: width must be a pair number"
let center_y = half_or_raise height "center_y: height must be a pair number"

(*
 * DOMAIN
 *)
type circle = { x : int; y : int }

let circle = ref { x = 0; y = 0 }

(*
 * UPDATE
 *)
let update () =
  let do_update_y = !circle.x mod 2 = 0 in
  circle :=
    { x = !circle.x + 1
    ; y =
        (if do_update_y then
          !circle.y + 1
        else
          !circle.y)
    }
;;

(*
 * VIEW
 *)
let draw () =
  ()
  ; R.clear_background Color.black
  ; R.draw_circle !circle.x !circle.y 50.0 Color.yellow
;;

(*
 * BOOTSTRAP
 *)
let run () =
  while not @@ R.window_should_close () do
    ()
    ; update ()
    ; R.begin_drawing ()
    ; draw ()
    ; R.end_drawing ()
  done
;;
