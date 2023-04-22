(*

dune exec --display=quiet bin/main.exe && eog /tmp/white-noise.ppm


---

The performance is slightly better than C (0m0.029s), slightly worse than Rust (0m0.010s).

dune build --profile release

$ time _build/default/bin/main.exe

real    0m0.023s
user    0m0.019s
sys     0m0.004s

 *)

let () = Noise.run ()
