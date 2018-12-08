module D = Drawing
module G = Generators
module H = Helpers
module L = List
module R = Random
module S = Deboor

let fl_of_in = float_of_int
let in_of_fl = int_of_float

let () =
    R.self_init ();

    let n = 2 + R.int 3 in
    let ns = List.init n (fun _ -> 3 + R.int 5) in
    let words =
        G.sent_pts ~ns
            ~sent_start:0.25 ~word_sep:0.05 ~char_sep:1.0 ~char_range:1.0
            ~y_min:0.0 ~y_max:1.0 in

    let pad = 0.25 in
    let k = fl_of_in @@ H.sum_int ns in
    let j = 1.0 +. (pad /. 2.0) +. (k -. (k *. pad)) in
    let res = 200 * (in_of_fl k + 1) in
    let y_bound = 350 in
    let x_bound = in_of_fl @@ ceil @@ fl_of_in y_bound *. j in

    let surface, cr = D.init_surface x_bound y_bound in
    D.antialias cr;

    let x_bound = fl_of_in x_bound and y_bound = fl_of_in y_bound in
    D.rect cr ~x:0.0 ~y:0.0 ~w:x_bound ~h:y_bound ~r:1.0 ~g:1.0 ~b:1.0;

    D.margins cr ~w:y_bound ~h:y_bound ~pad;

    let splines = List.map (fun word -> S.bspline word res 3) words in

    let r = 0.0 and g = 0.0 and b = 0.0 in
    List.iter
        (fun spline -> D.lines cr ~pts:spline ~lw:0.005 ~r ~g ~b) splines;

    D.export surface "../out/sentence.png"
