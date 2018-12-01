let draw_rect cr ~x ~y ~w ~h ~r ~g ~b =
    Cairo.rectangle cr ~x:x ~y:y ~w:w ~h:h;
    Cairo.set_source_rgb cr r g b;
    Cairo.fill cr

let init_margins cr margin bound =
    Cairo.translate cr margin margin;
    Cairo.scale cr bound bound

let () =
    let bound = 120 in
    let boundf = float_of_int bound in
    let margin = boundf /. 10.0 in
    let inner_boundf = boundf *. 0.8 in
    let surface = Cairo.Image.create Cairo.Image.ARGB32 bound bound in
    let cr = Cairo.create surface in

    draw_rect cr
        ~x:0.0 ~y:0.0 ~w:boundf ~h:boundf
        ~r:0.0 ~g:0.0 ~b:0.0;

    init_margins cr margin inner_boundf;

    draw_rect cr
        ~x:0.0 ~y:0.0 ~w:1.0 ~h:1.0
        ~r:1.0 ~g:1.0 ~b:1.0;
    draw_rect cr
        ~x:0.25 ~y:0.25 ~w:0.5 ~h:0.5
        ~r:0.5 ~g:0.5 ~b:1.0;

    Cairo.PNG.write surface "margin.png";
    Cairo.Surface.finish surface
