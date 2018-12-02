let rec last default = function
    | [] -> default
    | [x] -> x
    | (_ :: xs) -> last default xs

let rec zip_with f xs ys = match xs, ys with
    | (x :: xs), (y :: ys) -> f x y :: zip_with f xs ys
    | [], _ | _, [] -> []

let rec cox_deboor knots u k d =
    if d == 0 then if knots.(k) <= u && u < knots.(k + 1) then 1.0 else 0.0
    else
        let safe_div denom eq = if denom > 0.0 then eq else 0.0 in
        let a =
            let denom = knots.(k + d) -. knots.(k) in
            let eq =
                ((u -. knots.(k)) /. denom)
                *. (cox_deboor knots u k (d - 1)) in
            safe_div denom eq in
        let b =
            let denom = knots.(k + d + 1) -. knots.(k + 1) in
            let eq =
                ((knots.(k + d + 1) -. u) /. denom)
                *. (cox_deboor knots u (k + 1) (d - 1)) in
            safe_div denom eq in
        a +. b

let bspline cvs n d =
    let dim = List.length @@ List.hd cvs in
    let count = List.length cvs in
    let us =
        let f x =
            (float_of_int x /. (float_of_int n -. 1.0))
            *. (float_of_int count -. float_of_int d) in
        List.init n f in
    let knots = Array.concat [ Array.make d 0.0
                             ; Array.init (count - d + 1) float_of_int
                             ; Array.make d @@ float_of_int @@ count - d
                             ] in
    let rec loop u k accu = function
        | [] -> accu
        | (cv :: cvs) ->
            let cox_deboor = cox_deboor knots u k d in
            let accu =
                let iter = List.map (fun x -> cox_deboor *. x) cv in
                zip_with (+.) accu iter in
            loop u (k + 1) accu cvs in
    let zeros = List.init dim (fun _ -> 0.0) in
    let thresh = float_of_int @@ count - d in
    let sample u = if u = thresh then last [] cvs else loop u 0 zeros cvs in
    List.map sample us

let main () =
    let cvs = [ [ 50.0; 25.0;   0.0 ]
              ; [ 59.0; 12.0; (-1.0)]
              ; [ 50.0; 10.0;   1.0 ]
              ; [ 57.0;  2.0;   2.0 ]
              ; [ 40.0;  4.0; (-1.0)]
              ; [ 40.0; 14.0;   0.0 ]
              ] in
    bspline cvs 10 3
