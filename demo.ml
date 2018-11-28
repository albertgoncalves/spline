let surface = Cairo.Image.create Cairo.Image.ARGB32 500 500

let cr =
    let cr = Cairo.create surface in
    Cairo.set_line_width cr 1.0;
    cr

let rand_rgb seed =
    let rand seed =
        Random.init seed;
        Random.float 1.0 in
    let a = rand (seed + 10) in
    let b = rand (seed + 20) in
    let c = rand (seed + 30) in
    (* Funs.print_strlist @@ List.map string_of_float [a; b; c]; *)
    Cairo.set_source_rgb cr a b c

let dot x y =
    let pi = 4.0 *. atan 1.0 in
    Cairo.arc cr x y 15.0 0.0 (2.0 *. pi);
    Cairo.stroke cr

let curve seed x1 y1 x2 y2 x3 y3 =
    rand_rgb seed;
    Cairo.stroke cr;
    Cairo.curve_to cr x1 y1 x2 y2 x3 y3;
    Cairo.stroke cr;
    List.iter (fun (x, y) -> dot x y) [(x1, y1); (x2, y2); (x3, y3)]

let save surface filename =
    Cairo.PNG.write surface filename

let apply_unit func arg = function
    | [a; b; c; d; e; f] -> func arg a b c d e f
    | _ -> ()

let main () =
    List.iter
        (fun seed -> apply_unit curve seed (Funs.randf seed 25.0 475.0 6))
        [1; 99; 55; 31; 62; 76];
    save surface "demo.png"

let () = main ()
