let init_surface ~w ~h =
    let surface = Cairo.Image.create Cairo.Image.ARGB32 w h in
    let cr = Cairo.create surface in
    surface, cr

let init_margins cr ~w ~h ~pad =
    let slide x = x *. pad /. 2.0 in
    let shrink x = x *. (1.0 -. pad) in
    Cairo.translate cr (slide w) (slide h);
    Cairo.scale cr (shrink w) (shrink h)

let draw_rect cr ~x ~y ~w ~h ~r ~g ~b =
    Cairo.rectangle cr ~x:x ~y:y ~w:w ~h:h;
    Cairo.set_source_rgb cr r g b;
    Cairo.fill cr

let export surface filename =
    Cairo.PNG.write surface filename;
    Cairo.Surface.finish surface

let () =
    let bound = 200 in
    let surface, cr = init_surface bound bound in

    let bound = float_of_int bound in
    draw_rect cr ~x:0.0 ~y:0.0 ~w:bound ~h:bound ~r:0.0 ~g:0.0 ~b:0.0;
    init_margins cr ~w:bound ~h:bound ~pad:0.15;
    List.iter
        (fun ((x, y, w, h), (r, g, b)) -> draw_rect cr x y w h r g b)
        [ ((0.0, 0.0, 1.0, 1.0), (1.0, 1.0, 1.0))
        ; ((0.25, 0.25, 0.5, 0.5), (0.2, 0.65, 0.55))
        ];

    export surface "margin.png"
