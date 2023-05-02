(* Lerp stands for Linear intERPolation *)

let lerp_1d lo hi t =
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

(** Given an array of reference points, returns any point `x`, "smoothly" interpolated against the previous and next
    ref points.

    If there is no next ref point, the first ref point is chosen. This enables seamlessly repeating the noise pattern.

    Also signal to the caller if we've "hit" a reference point. This enables the caller to draw peaks and valleys differently
    from the rest of the interpolated points.
  *)
let point_at x ~ref_points ~ref_points_size =
  let lo = int_of_float x mod ref_points_size in
  let hi = (lo + 1) mod ref_points_size in
  let t = x -. float_of_int lo in
  let interpolated = lerp_1d ref_points.(lo) ref_points.(hi) (smooth t) in
  let ref_point = ref_points.(int_of_float x) in
  let is_hit = interpolated = ref_point in
  (interpolated, is_hit)
;;
