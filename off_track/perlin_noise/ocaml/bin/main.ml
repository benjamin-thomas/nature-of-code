(*

dune exec --display=quiet ./bin/main.exe 1 && eog /tmp/ocaml-white-noise.ppm

The performance is slightly better than C (0m0.029s), slightly worse than Rust (0m0.010s).

dune build --profile release

$ time _build/default/bin/main.exe 1

real    0m0.023s
user    0m0.019s
sys     0m0.004s

 *)

let usage =
  {|
Usage:

  ./main.exe SELECTION

  Available SELECTION values:

  - 1: generate a white-noise PPM image
  - 2: open a window, demonstrating the usage of a noise 1D function applied to some random points

1.
|}
;;

type selection = GenerateWhiteNoise | GraphWithNoise1D

let selection_of_int = function
  | 1 -> GenerateWhiteNoise
  | 2 -> GraphWithNoise1D
  | _ -> raise @@ Invalid_argument "not a valid selection"
;;

let get_selection () =
  try Sys.argv.(1) |> int_of_string |> selection_of_int with
  | _ ->
      print_endline usage
      ; exit 1
;;

let () =
  match get_selection () with
  | GenerateWhiteNoise -> Noise.generate_white_noise ()
  | GraphWithNoise1D -> print_endline "TODO"
;;
