(*
  dune exec bin/main.exe
*)

let setup () =
  ()
  ; Raylib.init_window 800 450 "OCaml/Raylib: CHANGE_ME"
  ; Raylib.set_target_fps 60
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

let rec loop () =
  if Raylib.window_should_close () then
    Raylib.close_window ()
  else
    let open Raylib in
    ()
    ; begin_drawing ()
    ; clear_background Color.black

    ; update ()
    ; draw_circle !circle.x !circle.y 50.0 Color.yellow
    ; end_drawing ()
    ; loop ()
;;

let () =
  ()
  ; setup ()
  ; loop ()
;;
