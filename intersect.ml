let distance a b =
    let ax, ay = a in
    let bx, by = b in
    sqrt @@ (Float.pow (bx -. ax) 2.0) +. (Float.pow (by -. ay) 2.0)

let round n x =
    let limit = Float.pow 10.0 n in
    (Float.floor (x *. limit)) /. limit

let point_along pt l =
    let a, b = l in
    let round x = round 10.0 x in
    Float.equal
        (round ((distance a pt) +. (distance b pt)))
        (round (distance a b))

let ccw a b c =
    let ax, ay = a in
    let bx, by = b in
    let cx, cy = c in
    ((cy -. ay) *. (bx -. ax)) > ((by -. ay) *. (cx -. ax))

let rec on_line pt = function
    | (ab :: l) ->
        if point_along pt ab then true
        else on_line pt l
    | _ -> false

let check_endpoints ab cd =
    let a, b = ab in
    let c, d = cd in
    if on_line a [cd] then true else
    if on_line b [cd] then true else
    if on_line c [ab] then true else
    if on_line d [ab] then true else false
