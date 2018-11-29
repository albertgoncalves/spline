let dim = 8

let arr =
    let arr = Array.make dim 0 in
    let x = 4 in
    Array.set arr x 1;
    arr.(x + 2) <- 8;
    arr

let mat =
    let mat = Array.make_matrix (dim / 2) dim 0 in
    let x = 0 in
    let y = x + 1 in
    mat.(x).(y) <- 9;
    mat

let main () =
    Printf.printf "%d\n" @@ Array.length arr;
    Array.iter (fun x -> print_int @@ Array.length x) mat;
    print_newline ()

let () = main ()
