(*
 * dune exec --display=quiet bin/main.exe
 *)

module Sdl = Tsdl.Sdl
module Window = Sdl.Window
module Event = Sdl.Event

let ( let* ) = Result.bind

type error_ctx =
  | Partial of { window : Sdl.window }
  | Full of { window : Sdl.window; renderer : Sdl.renderer }

(* Attach extra context to the original error.
 * Used for resource cleanup on program exit.
 *)
let with_err_ctx ctx = Result.map_error (fun err -> (err, ctx))

let init_window () =
  let* () = Sdl.init Sdl.Init.(audio + video) in
  let* window =
    Sdl.create_window "OCaml/TSDL: CHANGE_ME" ~x:Window.pos_centered
      ~y:Window.pos_centered ~w:640 ~h:480 Window.shown
  in

  Ok window
;;

let render_frame renderer (x, y) =
  let* () = Sdl.set_render_draw_color renderer 255 127 40 255 in
  let* () = Sdl.render_clear renderer in
  let* () = Sdl.set_render_draw_color renderer 255 0 0 255 in
  let* () =
    Sdl.render_fill_rect renderer (Some (Sdl.Rect.create ~x ~y ~w:70 ~h:70))
  in
  ()
  ; Sdl.render_present renderer
  ; Ok ()
;;

type state = { quit : bool; pos : int * int }

let initial_state = { quit = false; pos = (0, 0) }

let poll evt state =
  let (x, y) = state.pos in
  let default = { state with pos = (x + 2, y + 1) } in

  if Sdl.poll_event (Some evt) then
    match Event.(enum (get evt typ)) with
    | `Quit -> { state with quit = true }
    | _ -> default
  else
    default
;;

let run_game_loop renderer =
  let rec loop evt state =
    if not state.quit then (
      let state = poll evt state in
      let* () = render_frame renderer state.pos in
      ()
      ; Sdl.delay 17l (* approx 60 FPS *)
      ; loop evt state
    ) else
      Ok ()
  in

  let evt = Event.create () in
  loop evt initial_state
;;

let start_game () =
  let* window = init_window () |> with_err_ctx None in
  let* renderer =
    Sdl.create_renderer window |> with_err_ctx (Some (Partial { window }))
  in
  let* () =
    run_game_loop renderer |> with_err_ctx (Some (Full { window; renderer }))
  in

  Ok (window, renderer)
;;

let rec destroy_resources = function
  | Some (Full { window; renderer }) ->
      ()
      ; Sdl.destroy_renderer renderer
      ; destroy_resources @@ Some (Partial { window })
  | Some (Partial { window }) ->
      ()
      ; Sdl.destroy_window window
  | None -> ()
;;

let () =
  match start_game () with
  | Ok (window, renderer) ->
      ()
      ; Sdl.destroy_renderer renderer
      ; Sdl.destroy_window window
      ; Sdl.quit ()
      ; exit 0
  | Error (`Msg msg, ctx) ->
      ()
      ; Sdl.log "Error: %s" msg
      ; destroy_resources ctx
      ; Sdl.quit ()
      ; exit 1
;;
