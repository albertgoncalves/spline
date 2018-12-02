module C = Cairo
module F = Float
module L = List
module R = Random

let init_surface ~w ~h =
    let surface = C.Image.create C.Image.ARGB32 w h in
    let cr = C.create surface in
    surface, cr

let antialias cr = C.set_antialias cr C.ANTIALIAS_SUBPIXEL

let init_margins cr ~w ~h ~pad =
    let slide x = x *. pad /. 2.0 in
    let shrink x = x *. (1.0 -. pad) in
    C.translate cr (slide w) (slide h);
    C.scale cr (shrink w) (shrink h)

let draw_rect cr ~x ~y ~w ~h ~r ~g ~b =
    C.rectangle cr ~x:x ~y:y ~w:w ~h:h;
    C.set_source_rgb cr r g b;
    C.fill cr

let brush cr lw r g b =
    C.set_line_width cr lw;
    C.set_source_rgb cr r g b

let lines cr ~pts ~lw ~r ~g ~b =
    let line = function
        | [x; y] -> C.line_to cr x y
        | _ -> () in

    brush cr lw r g b;
    L.iter (fun pt -> line pt) pts;
    C.stroke cr

let dots cr ~pts ~lw ~rad ~r ~g ~b =
    let dot = function
        | [x; y] ->
            C.arc cr x y rad 0.0 (2.0 *. F.pi);
            C.stroke cr
        | _ -> () in

    brush cr lw r g b;
    L.iter (fun pt -> dot pt) pts

let rand_pts n min max =
    let rand_pt () = min +. R.float (max -. min) in
    L.init n (fun _ -> [rand_pt (); rand_pt ()])

let export surface filename =
    C.PNG.write surface filename;
    C.Surface.finish surface
