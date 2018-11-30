let distance a b =
    let ax, ay = a in
    let bx, by = b in
    sqrt @@ (Float.pow (bx -. ax) 2.0) +. (Float.pow (by -. ay) 2.0)

let round n x =
    let limit = Float.pow 10.0 n in
    (Float.floor (x *. limit)) /. limit

let point_along pt l =
    let a, b = l in
    let dist j k = round 10.0 @@ distance j k in
    let apt = dist a pt in
    let bpt = dist b pt in
    let ab = dist a b in
    Float.equal (apt +. bpt) ab

let ccw a b c =
    let ax, ay = a in
    let bx, by = b in
    let cx, cy = c in
    let delta j k = (j -. ay) *. (k -. ax) in
    (delta cy bx) > (delta by cx)

let rec on_line pt = function
    | (ab :: l) ->
        if point_along pt ab then true
        else on_line pt l
    | _ -> false

let check_endpoints ab cd =
    let a, b = ab in
    let c, d = cd in
    if on_line a [cd] then true
    else if on_line b [cd] then true
    else if on_line c [ab] then true
    else if on_line d [ab] then true
    else false

let intersect ab cd =
    let a, b = ab in
    let c, d = cd in
    let acd = ccw a c d in
    let bcd = ccw b c d in
    let abc = ccw a b c in
    let abd = ccw a b d in
    if (acd <> bcd) && (abc <> abd) then true
    else check_endpoints ab cd

let rand_pt min max =
    let rand () = min +. Random.float (max -. min) in
    rand (), rand ()

let rand_pts n min max =
    let n = abs n in
    let rec loop l n = match n with
        | 0 -> l
        | _ ->
            let pt = rand_pt min max in
            loop (pt :: l) (n - 1) in
    loop [] n

let grow min max =
    let rec loop acc ls = match ls with
        | (a :: b :: c :: d :: l) ->
            if intersect (a, b) (c, d) then acc
            else loop acc (a :: b :: d :: l)
        | l ->
            let pt = rand_pt min max in
            loop (pt :: acc) (pt :: acc) in
    loop [] []

let draw_lines cr pts =
    let line xy =
        let x, y = xy in
        Cairo.line_to cr x y in
    List.iter line pts

let main () =
    Random.init 9;
    let bound = 500 in
    let surface = Cairo.Image.create Cairo.Image.ARGB32 bound bound in
    let cr = Cairo.create surface in
    Cairo.set_source_rgb cr 0.0 0.0 0.0;
    Cairo.set_antialias cr Cairo.ANTIALIAS_SUBPIXEL;
    Cairo.set_line_width cr 2.0;
    draw_lines cr @@ grow 0.0 500.0;
    Cairo.stroke cr;
    Cairo.PNG.write surface "intersect.png"

let () = main ()
