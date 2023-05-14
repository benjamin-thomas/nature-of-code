(*
 * dune exec --display=quiet bin/main.exe
 *)

let proc_event = function
  | Sdlevent.Quit _ ->
      Sdl.quit ()
      ; exit 0
  | _ -> ()
;;

let rec handle_events () =
  match Sdlevent.poll_event () with
  | Some evt ->
      proc_event evt
      ; handle_events ()
  | None -> ()
;;

let bg_color = (255, 127, 40)
let rect_color = (255, 0, 0)
let target_fps = 60
let min_delay_ms = 1000 / target_fps
let rect_pos = ref (0.0, 0.0)
let speed = 0.1

let () =
  let () = Sdl.init [ `AUDIO; `VIDEO ] in
  let win =
    Sdl.Window.create ~title:"OCaml/SDL2 : CHANGE_ME"
      ~pos:(`centered, `centered) ~dims:(600, 400) ~flags:[ Sdlwindow.Shown ]
  in

  let renderer =
    Sdl.Render.create_renderer ~win ~index:(-1) ~flags:[ Sdlrender.Accelerated ]
  in
  let rect = ref @@ Sdl.Rect.make ~pos:(0, 0) ~dims:(70, 70) in
  let last_tick = Sdltimer.get_ticks () in

  (* loop *)
  while true do
    let delta_time = Sdltimer.get_ticks () - last_tick in
    let dt = float_of_int delta_time /. 1000.0 in

    ()
    ; handle_events ()
    ; rect_pos :=
        (fst !rect_pos +. (speed *. 2.0 *. dt), snd !rect_pos +. (speed *. dt))
    ; rect :=
        { !rect with
          x = int_of_float (fst !rect_pos)
        ; y = int_of_float (snd !rect_pos)
        }
    ; Sdl.Render.set_draw_color renderer ~rgb:bg_color ~a:255
    ; Sdl.Render.clear renderer
    ; Sdl.Render.set_draw_color renderer ~rgb:rect_color ~a:255
    ; Sdl.Render.fill_rect renderer !rect
    ; Sdl.Render.render_present renderer
    ; let delay_ms = min_delay_ms - delta_time in
      if delay_ms > 0 then Sdltimer.delay ~ms:delay_ms
  done
;;
