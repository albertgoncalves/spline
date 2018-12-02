module D = Drawing
module S = Deboor
module L = List
module R = Random

let () =
    let bound = 350 in
    let surface, cr = D.init_surface bound bound in

    let bound = float_of_int bound in
    D.draw_rect cr ~x:0.0 ~y:0.0 ~w:bound ~h:bound ~r:1.0 ~g:1.0 ~b:1.0;
    D.init_margins cr ~w:bound ~h:bound ~pad:0.15;

    R.self_init ();
    let pts =
        let n = 4 + R.int 5 in
        assert (n > 3);
        D.rand_pts n 0.0 1.0 in
    let r = 0.0 and g = 0.0 and b = 0.0 in
    let spline = S.bspline pts 100 3 in

    D.dots cr ~pts ~lw:0.002 ~rad:0.05 ~r ~g ~b;
    D.lines cr ~pts ~lw:0.001 ~r ~g ~b;
    D.lines cr ~pts:spline ~lw:0.005 ~r ~g ~b;

    D.export surface "spline.png"
