type color = { r : float; g : float; b : float }
type dimensions = { width : int; height : int }

let output_pixel oc colors scale =
  let scale = float_of_int scale in
  let rand_idx = Random.int @@ Array.length colors in
  let color = colors.(rand_idx) in
  let r = color.r *. scale in
  let g = color.g *. scale in
  let b = color.b *. scale in
  ()
  ; output_byte oc @@ int_of_float @@ r
  ; output_byte oc @@ int_of_float @@ g
  ; output_byte oc @@ int_of_float @@ b
;;

let output_pixels oc dim colors scale =
  for _x = 1 to dim.width do
    for _y = 1 to dim.height do
      output_pixel oc colors scale
    done
  done
;;

let gen_ppm dim colors ?(scale = 255) oc () =
  let ppm_magic_number = "P6" in
  let str_width_height =
    string_of_int dim.width ^ " " ^ string_of_int dim.height
  in
  ()
  ; output_string oc @@ ppm_magic_number ^ "\n"
  ; output_string oc @@ str_width_height ^ "\n"
  ; output_string oc @@ string_of_int scale ^ "\n"
  ; output_pixels oc dim colors scale
;;

let run () =
  let colors =
    [| { r = 0.4078; g = 0.4078; b = 0.3764 }
     ; { r = 0.7606; g = 0.6274; b = 0.6313 }
     ; { r = 0.8980; g = 0.9372; b = 0.9725 }
    |]
  in
  let dim = { width = 512; height = 512 } in
  let filename = "/tmp/white-noise.ppm" in

  let oc = open_out filename in

  ()
  ; gen_ppm dim colors oc ()
  ; close_out oc
  ; print_endline @@ "Generated noise at: " ^ filename
;;
