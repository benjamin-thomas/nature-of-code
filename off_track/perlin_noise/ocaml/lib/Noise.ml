(* module WhiteNoise = WhiteNoise *)
module Noise1D = Noise1D

let generate_white_noise () = WhiteNoise.generate "/tmp/ocaml-white-noise.ppm"
