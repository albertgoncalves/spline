module D = Drawing
module G = Generators
module L = List
module R = Random
module S = Deboor

let () =
    R.self_init ();

    let k = 3 + R.int 2 in
    let res = 200 * (k + 1) in
    let y_bound = 350 in
    let x_bound = y_bound * k in

    let surface, cr = D.init_surface x_bound y_bound in
    D.antialias cr;

    let x_bound = float_of_int x_bound and y_bound = float_of_int y_bound in
    D.rect cr ~x:0.0 ~y:0.0 ~w:x_bound ~h:y_bound ~r:1.0 ~g:1.0 ~b:1.0;
    D.margins cr ~w:y_bound ~h:y_bound ~pad:0.4;

    let pts =
        G.word_pts
            ~n:(k + 1)
            ~word_start:0.25
            ~char_sep:1.0
            ~char_range:1.0
            ~y_min:0.0
            ~y_max:1.0 in

    let r = 0.0 and g = 0.0 and b = 0.0 in
    let spline = S.bspline pts res 3 in

    D.lines cr ~pts:spline ~lw:0.005 ~r ~g ~b;

    D.export surface "../out/word.png"
