(*
    dune exec --display=quiet bin/noise_1d.exe
*)

module R = Raylib
module Color = R.Color
module Noise1D = Noise.Noise1D

(*
 * UTILS
 *)

let debug_print_ref_points ref_points =
  let string_of_ref_points =
    ref_points
    |> Array.to_list
    |> List.map (Printf.sprintf "%0.3f")
    |> String.concat ", "
  in
  Printf.printf "--> REF_POINTS: [%s]\n%!" string_of_ref_points
;;

(*
 * WINDOW
 *)
let window_w = 640
let window_h = 360

let setup () =
  ()
  ; R.set_config_flags [ R.ConfigFlags.Msaa_4x_hint ]
  ; R.set_target_fps 60
  ; R.init_window window_w window_h "OCaml/Raylib: Noise 1D"
;;

(*
 * DOMAIN
 *)
type point = { x : int; y : int; size : float; color : Color.t }

(*
 * UPDATE
 *)

let ratio n total scale =
  float_of_int n /. float_of_int total *. float_of_int scale
;;

let step_over ref_points ~ref_points_size ~all_points_size fn =
  let point_at = Noise1D.point_at ~ref_points ~ref_points_size in
  for i = 0 to all_points_size - 1 do
    let progression = ratio i all_points_size ref_points_size in
    let interpolated = point_at progression in
    fn ~i ~interpolated
  done
;;

let make_point ~all_points_size ~i ~interpolated:(n, is_hit) =
  let x = int_of_float (ratio i all_points_size window_w) in
  let y = int_of_float (n *. float_of_int window_h) in
  let (size, color) =
    if is_hit then
      (5.0, Color.green)
    else
      (2.0, Color.white)
  in
  { x; y; size; color }
;;

let update all_points ~all_points_size ref_points ~ref_points_size =
  step_over ref_points ~ref_points_size ~all_points_size
    (fun ~i ~interpolated ->
      all_points.(i) <- make_point ~all_points_size ~i ~interpolated)
;;

(*
 * VIEW
 *)

let draw_point point = R.draw_circle point.x point.y point.size point.color
let bg_color = Color.black

let draw all_points =
  ()
  ; R.clear_background bg_color
  ; Array.iter draw_point all_points
;;

(*
 * BOOTSTRAP
 *)

let seed =
  try Sys.argv.(1) |> int_of_string with
  | _ ->
      let () = print_endline "Invalid or unspecified seed: using 0!" in
      0
;;

let new_point = { x = 0; y = 0; size = 0.0; color = bg_color }

let () =
  let () = Random.init seed in
  let ref_points_size = 10 in
  let ref_points = Array.init ref_points_size (fun _ -> Random.float 1.0) in
  let all_points_size = 2000 in
  let all_points = Array.init all_points_size (fun _ -> new_point) in

  ()
  ; debug_print_ref_points ref_points
  ; setup ()
  ; while not @@ R.window_should_close () do
      ()
      ; update all_points ~all_points_size ref_points ~ref_points_size
      ; R.begin_drawing ()
      ; draw all_points
      ; R.end_drawing ()
    done
;;
