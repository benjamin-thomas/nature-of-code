external glClearColorBufferBit : unit -> unit = "caml_glClearColorBufferBit"

open Printf

let print_monitor i monitor =
  let monitor_name = GLFW.getMonitorName ~monitor in
  let (x, y) = GLFW.getMonitorPos ~monitor in
  ()
  ; printf "%d) name: %s\n%!" i monitor_name
  ; printf "%d) pos: (%d,%d)\n%!" i x y
;;

let print_monitors () =
  let monitors = GLFW.getMonitors () in
  List.iteri print_monitor monitors
;;

let game_loop window =
  while not (GLFW.windowShouldClose ~window) do
    ()
    ; glClearColorBufferBit ()
    ; GLFW.swapBuffers ~window
    ; GLFW.pollEvents ()
    ; print_monitors ()
  done
;;

let set_monitor window =
  let monitor = List.nth (GLFW.getMonitors ()) 1 in
  GLFW.setWindowMonitor ~window ~monitor:(Some monitor) ~xpos:0 ~ypos:0
    ~refreshRate:(Some 30) ~width:1366 ~height:768
;;

(* TODO: Find out how to draw a vertex. I think I may need to implement more C stubs.
   let draw_triangle () =
     GlDraw.begins `triangles;
     GlDraw.vertex2 (-0.5, -0.5);
     GlDraw.vertex2 (0.5, -0.5);
     GlDraw.vertex2 (0.0, 0.5);
     GlDraw.ends (); *)

let () =
  let () = GLFW.init () in
  let () = at_exit GLFW.terminate in
  let window =
    GLFW.createWindow ~width:640 ~height:480 ~title:"Hello from GLFW!" ()
  in
  let () = GLFW.makeContextCurrent ~window:(Some window) in
  let () = set_monitor window in
  game_loop window
;;
