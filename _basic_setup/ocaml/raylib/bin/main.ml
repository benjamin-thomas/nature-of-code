(*
  dune exec bin/main.exe
*)

module R = Raylib
module Color = R.Color

let setup () =
  ()
  ; R.init_window 800 450 "OCaml/Raylib: CHANGE_ME"
  ; R.set_target_fps 60
;;

type circle = { x : int; y : int }

let circle = ref { x = 0; y = 0 }

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

let run () =
  while not @@ R.window_should_close () do
    ()
    ; R.begin_drawing ()
    ; R.clear_background Color.black

    ; update ()
    ; R.draw_circle !circle.x !circle.y 50.0 Color.yellow
    ; R.end_drawing ()
  done
;;

let () =
  ()
  ; setup ()
  ; run ()
;;
