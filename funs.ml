let frange a b incr =
    let compare, incr =
        if b > a then
            (<=), incr *. (-1.0)
        else
            (>=), incr in
    let rec loop n l =
        let x = b +. (n *. incr) in
        if compare x a then (x :: l)
        else loop (n +. 1.0) (x :: l) in
    loop 1.0 []

let randf seed bound n =
    Random.init seed;
    let rand = (fun _ -> Random.float bound) in
    let rec loop acc = function
        | 0 -> acc
        | n -> loop (rand () :: acc) (n - 1) in
    loop [] n

let print_strlist l =
    print_string @@ Printf.sprintf "[%s]\n" @@ String.concat "; " l

let main =
    List.iter (fun x -> print_strlist @@ List.map string_of_float x)
        [frange 0.0 10.0 0.5; randf 10 1.0 10]

let () = main
