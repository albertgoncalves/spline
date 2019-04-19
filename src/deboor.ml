module A = Array
module H = Helpers
module L = List

let rec cox_deboor (knots : float array) (u : float) (k : int) (d : int)
    : float =
    if d == 0 then
        if knots.(k) <= u && u < knots.(k + 1) then
            1.0
        else
            0.0
    else
        let a =
            let den = knots.(k) -. knots.(k + d) in
            if den <> 0.0 then
                (cox_deboor knots u k (d - 1)) *. ((knots.(k) -. u) /. den)
            else
                0.0 in
        let b =
            let den = knots.(k + d + 1) -. knots.(k + 1) in
            if den <> 0.0 then
                let num = knots.(k + d + 1) -. u in
                (cox_deboor knots u (k + 1) (d - 1)) *. (num /. den)
            else
                0.0 in
        a +. b

let bspline (cvs : float list list) (n : int) (d : int) : float list list =
    let count : int = L.length cvs in
    let knots : float array =
        A.concat
            [ A.make d 0.0
            ; A.init (count - d + 1) float_of_int
            ; count - d |> float_of_int |> A.make d
            ] in
    let rec loop (u : float) (k : int) (accu : float list) = function
        | [] -> accu
        | (cv::cvs) ->
            let xs = (L.map (( *.) (cox_deboor knots u k d)) cv) in
            loop u (k + 1) (H.zip_with (+.) accu xs) cvs in
    let us : float list =
        let f x =
            (float_of_int x /. (float_of_int n -. 1.0))
            *. (float_of_int count -. float_of_int d) in
        L.init n f in
    let sample (u : float) : float list =
        if u = float_of_int (count - d) then
            H.last [] cvs
        else
            loop u 0 (L.init (H.head [] cvs |> L.length) (fun _ -> 0.0)) cvs in
    L.map sample us
