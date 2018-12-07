module D = Drawing
module G = Generators
module L = List
module R = Random
module S = Deboor

let () =
    let bound = 350 in
    let surface, cr = D.init_surface bound bound in
    D.antialias cr;

    let bound = float_of_int bound in
    D.rect cr ~x:0.0 ~y:0.0 ~w:bound ~h:bound ~r:1.0 ~g:1.0 ~b:1.0;
    D.margins cr ~w:bound ~h:bound ~pad:0.15;

    R.self_init ();
    let pts =
        let n = 4 + R.int 5 in
        assert (n > 3);
        G.char_pts ~n [] ~x_min:0.0 ~x_max:1.0 ~y_min:0.0 ~y_max:1.0 in
    let r = 0.0 and g = 0.0 and b = 0.0 in
    let spline = S.bspline pts 100 3 in

    D.dots cr ~pts ~lw:0.002 ~rad:0.05 ~r ~g ~b;
    D.lines cr ~pts ~lw:0.001 ~r ~g ~b;
    D.lines cr ~pts:spline ~lw:0.005 ~r ~g ~b;

    D.export surface "../out/spline.png"
