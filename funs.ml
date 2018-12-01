let sort a b = if b >= a then (a, b) else (b, a)

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

let randf seed min max n =
    Random.init seed;
    let (a, b) = sort min max in
    let diff = b -. a in
    let rand = (fun _ -> a +. Random.float diff) in
    let rec loop acc = function
        | 0 -> acc
        | n -> loop (rand () :: acc) (n - 1) in
    loop [] n

let print_strlist l =
    print_string @@ Printf.sprintf "[%s]\n" @@ String.concat "; " l

let main () =
    List.iter
        (fun x -> print_strlist @@ List.map string_of_float x)
        [frange 0.0 10.0 0.5; randf 10 0.0 1.0 10]
