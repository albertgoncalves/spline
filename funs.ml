let frange a b incr =
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

let randf seed bound n =
    Random.init seed;
    let rand = (fun _ -> Random.float bound) in
    let rec loop acc = function
        | 0 -> acc
        | n -> loop (rand () :: acc) (n - 1) in
    loop [] n

let strlist_to_string l =
    Printf.sprintf "[%s]\n" @@ String.concat "; " l

let print_float_list l =
    print_string @@ strlist_to_string @@ List.map string_of_float l

let main =
    List.iter print_float_list [frange 0.0 10.0 0.5; randf 10 1.0 10]

let () = main
