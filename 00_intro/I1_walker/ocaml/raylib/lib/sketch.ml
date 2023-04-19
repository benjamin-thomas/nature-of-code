(*
   dune utop
   > Sketch.center_x
 *)

module R = Raylib
module Color = R.Color

let width = 640
let height = 360

let setup () =
  ()
  ; R.set_config_flags [ R.ConfigFlags.Msaa_4x_hint ]
  ; R.set_target_fps 60
  ; R.init_window width height "OCaml/Raylib: Random walker"
;;

type walker = { x : int; y : int }

let half_or_raise n err =
  let half = n / 2 in
  if half * 2 = n then
    half
  else
    raise @@ Invalid_argument err
;;

(*
   NOTE: `center_x` and `center_y` are executed on file load.
         So, the raise check **IS** executed once! (i.e. not on every call)
 *)
let center_x = half_or_raise width "center_x: width must be a pair number"
let center_y = half_or_raise height "center_y: height must be a pair number"
let walker = ref { x = center_x; y = center_y }

(** returns one of: [-1; 0, 1] *)
let next_step () = Random.int 3 - 1

let update () =
  walker := { x = !walker.x + next_step (); y = !walker.y + next_step () }
;;

let draw () =
  let size = 1 in
  R.draw_rectangle !walker.x !walker.y size size Color.white
;;

let run () =
  while not @@ R.window_should_close () do
    ()
    ; update ()

    ; R.begin_drawing ()
    ; draw ()
    ; R.end_drawing ()
  done
;;
