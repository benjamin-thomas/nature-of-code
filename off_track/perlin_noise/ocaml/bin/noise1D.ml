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

let make_vertices ~size () = Array.init size (fun _ -> Random.float 1.0)

let print_vertices vertices =
  let string_of_vertices =
    vertices
    |> Array.to_list
    |> List.map (Printf.sprintf "%0.3f")
    |> String.concat ", "
  in
  Printf.printf "--> [%s]\n" string_of_vertices
;;

(* Raylib *)

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
  ; R.init_window width height "OCaml/Raylib: Noise 1D"
;;

(*
let half_or_raise n err =
  let half = n / 2 in
  if half * 2 = n then
    half
  else
    raise @@ Invalid_argument err
;;

let center_x = half_or_raise width "center_x: width must be a pair number"
let center_y = half_or_raise height "center_y: height must be a pair number"
*)

(*
 * DOMAIN
 *)
(* type circle = { x : int; y : int } *)

(*
 * UPDATE
 *)
let update () = ()

(*
 * VIEW
 *)

let step_over vertices ~steps ~size fn =
  for i = 0 to steps - 1 do
    let progression =
      float_of_int i /. float_of_int steps *. float_of_int size
    in
    let interpolated = noise_1d vertices ~size progression in
    fn ~i ~progression ~interpolated
  done
;;

let draw vertices ~steps ~size =
  ()
  ; R.clear_background Color.black
  ; step_over vertices ~steps ~size
      (fun ~i:x ~progression:_ ~interpolated:(y, is_hit) ->
        let (x, y) : int * int =
          ( int_of_float
              (float_of_int x /. float_of_int steps *. float_of_int width)
          , int_of_float (y *. float_of_int height) )
        in
        let (size, color) =
          if is_hit then
            (5.0, Color.green)
          else
            (2.0, Color.white)
        in
        ()
        ; R.draw_circle x y size color)
;;

(*
 * BOOTSTRAP
 *)

let seed = 0

let () =
  let () = Random.init seed in
  let size = 10 in
  let vertices = make_vertices ~size () in
  let steps = 2000 in

  ()
  ; print_vertices vertices
  ; setup ()
  ; while not @@ R.window_should_close () do
      ()
      ; update () (* FIXME: separate update/draw *)
      ; R.begin_drawing ()
      ; draw vertices ~steps ~size
      ; R.end_drawing ()
    done
;;
