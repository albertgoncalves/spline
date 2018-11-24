let dim = 8

let arr =
    let arr = Array.make dim 0 in
    Array.set arr 6 1;
    arr.(2) <- 8;
    arr

let mat =
    let mat = Array.make_matrix (dim / 2) dim 0 in
    mat.(1).(1) <- 1;
    mat

let main =
    Printf.printf "%d\n" @@ Array.length arr;
    Array.iter (fun x -> print_int @@ Array.length x) mat;
    print_newline ()

let () = main
