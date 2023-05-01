(*
    dune exec --display=quiet bin2/noise1D.exe
*)

(* Lerp *)

let lerp1D lo hi t =
  let () = assert (t >= 0.0 && t <= 1.0) in
  (lo *. (1.0 -. t)) +. (hi *. t)
;;

(* To break down what's going on with the `smooth` function, see:

   - https://www.desmos.com/calculator/0upcotocgp
   - https://www.wolframalpha.com/input?i=plot+cos%28x%29%2C+1+-+cos%28x%29%2C+%281+-+cos%28x%29%29+*+0.5
*)
let smooth t =
  let () = assert (t >= 0.0 && t <= 1.0) in
  let cos_v  = cos (t *. Float.pi) in (* Range: -1..1 *)
  let shift = 1.0 -. cos_v in         (* Range:  0..2 *)
  shift *. 0.5                        (* Range:  0..1 *)
  [@@ocamlformat "disable"]

let noise_1d vertices ~size x =
  let lo = int_of_float x mod size in
  let hi = (lo + 1) mod size in
  let t = x -. float_of_int lo in
  let interpolated = lerp1D vertices.(lo) vertices.(hi) (smooth t) in
  let ref_point = vertices.(int_of_float x) in
  let is_ref_point = interpolated = ref_point in
  (interpolated, is_ref_point)
;;

let debug_print_ref_points ref_points =
  let string_of_ref_points =
    ref_points
    |> Array.to_list
    |> List.map (Printf.sprintf "%0.3f")
    |> String.concat ", "
  in
  Printf.printf "--> REF_POINTS: [%s]\n%!" string_of_ref_points
;;

(* Raylib *)

module R = Raylib
module Color = R.Color

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

let step_over ref_points ~ref_points_size ~all_points_size fn =
  for i = 0 to all_points_size - 1 do
    let progression =
      float_of_int i
      /. float_of_int all_points_size
      *. float_of_int ref_points_size
    in
    let interpolated = noise_1d ref_points ~size:ref_points_size progression in
    fn ~i ~interpolated
  done
;;

let set_point ~all_points_size ~i ~interpolated:(n, is_hit) =
  let (x, y) : int * int =
    let x =
      float_of_int i /. float_of_int all_points_size *. float_of_int window_w
    in
    let y = n *. float_of_int window_h in
    (int_of_float x, int_of_float y)
  in
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
      all_points.(i) <- set_point ~all_points_size ~i ~interpolated)
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
