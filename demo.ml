let bound = 500

let surface = Cairo.Image.create Cairo.Image.ARGB32 bound bound

let cr =
    let cr = Cairo.create surface in
    Cairo.set_source_rgb cr 0.0 0.0 0.0;
    cr

let save surface filename =
    Cairo.PNG.write surface filename

let extract f = function
    | [x; y; _] ->
        let scale = float_of_int bound in
        let x = ((x *. x) /. 5.0) -. (scale /. 2.0) in
        let y = scale -. (y *. 18.0) in
        f x y
    | _ -> ()

let lines =
    let line x y =
        Cairo.line_to cr x y in

    Cairo.set_line_width cr 3.5;
    List.iter (fun l -> extract line l) Tmp.y;
    Cairo.stroke cr

let dots =
    let dot x y =
        let pi = 4.0 *. atan 1.0 in
        Cairo.arc cr x y 15.0 0.0 (2.0 *. pi);
        Cairo.stroke cr in

    Cairo.set_line_width cr 1.5;
    List.iter (fun l -> extract dot l) Tmp.x

let main () =
    lines;
    dots;
    save surface "demo.png"

let () = main ()
