val point_at :
  float -> ref_points:float array -> ref_points_size:int -> float * bool
(** Given an array of reference points, returns any point `x`, "smoothly" interpolated against the previous and next
    ref points.

    If there is no next ref point, the first ref point is chosen. This enables seamlessly repeating the noise pattern.

    Also signal to the caller if we've "hit" a reference point. This enables the caller to draw peaks and valleys differently
    from the rest of the interpolated points.
  *)
