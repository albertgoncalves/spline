module A = Array
module L = List
module H = Helpers

let safe_div denom eq = if denom <> 0.0 then eq else 0.0

let rec cox_deboor knots u k d =
    if d == 0 then if knots.(k) <= u && u < knots.(k + 1) then 1.0 else 0.0
    else
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
    let dim = L.length @@ L.hd cvs in
    let count = L.length cvs in
    let knots = A.concat [ A.make d 0.0
                         ; A.init (count - d + 1) float_of_int
                         ; A.make d @@ float_of_int @@ count - d
                         ] in
    let rec loop u k accu = function
        | [] -> accu
        | (cv::cvs) ->
            let cox_deboor = cox_deboor knots u k d in
            let accu =
                let iter = L.map (fun x -> cox_deboor *. x) cv in
                H.zip_with (+.) accu iter in
            loop u (k + 1) accu cvs in
    let us =
        let f x =
            (float_of_int x /. (float_of_int n -. 1.0))
            *. (float_of_int count -. float_of_int d) in
        L.init n f in
    let zeros = L.init dim (fun _ -> 0.0) in
    let thresh = count - d in
    let last_cvs = H.last [] cvs in
    let sample u =
        if u = float_of_int thresh then last_cvs else loop u 0 zeros cvs in
    L.map sample us
