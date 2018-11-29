let bound = 1000
let surface = Cairo.Image.create Cairo.Image.ARGB32 bound bound

let cr =
    let cr = Cairo.create surface in
    Cairo.set_source_rgb cr 0.0 0.0 0.0;
    cr

let antialias = Cairo.set_antialias cr Cairo.ANTIALIAS_SUBPIXEL
let save filename = Cairo.PNG.write surface filename

let extract f = function
    | [x; y; _] ->
        let bound = float_of_int bound in
        let x = ((x *. x) /. 2.5) -. (bound /. 2.0) in
        let y = bound -. (y *. 35.0) in
        f x y
    | _ -> ()

let lines pts lw =
    let line x y = Cairo.line_to cr x y in

    Cairo.set_line_width cr lw;
    List.iter (fun pt -> extract line pt) pts;
    Cairo.stroke cr

let dots pts lw =
    let pi = 4.0 *. atan 1.0 in
    let dot x y =
        Cairo.arc cr x y 15.0 0.0 (2.0 *. pi);
        Cairo.stroke cr in

    Cairo.set_line_width cr lw;
    List.iter (fun pt -> extract dot pt) pts

let main () =
    lines Tmp.y 3.5;
    lines Tmp.x 1.0;
    dots Tmp.x 1.5;
    antialias;
    save "demo.png"

let () = main ()
