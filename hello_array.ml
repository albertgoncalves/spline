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

let frange a b incr =
    let dist = b -. a in
    let check, incr =
        if b > a then
            (<=), incr *. (-1.0)
        else
            (>=), incr in
    let rec loop n l =
        let x = b +. (n *. incr) in
        if check x a then (x :: l)
        else loop (n +. 1.0) (x :: l) in
    loop 1.0 []

let main =
    Printf.printf "%d\n" @@ Array.length arr;
    Array.iter (fun x -> print_int @@ Array.length x) mat;
    print_newline ();
    print_string "\nfrange 0.0 10.5 0.5\n";
    List.map (Printf.printf "%.2f ") (frange 0.0 10.5 0.5);
    print_string "\n\n"

let () = main
