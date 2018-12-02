let rec last default = function
    | [] -> default
    | [x] -> x
    | (_ :: xs) -> last default xs

let rec zip_with f xs ys = match (xs, ys) with
    | (x :: xs), (y :: ys) -> f x y :: zip_with f xs ys
    | ([], _) | (_, []) -> []

let rec cox_deboor knots u k d =
    if d == 0 then
        if (float_of_int knots.(k) <= u) &&
           (u < float_of_int knots.(k + 1)) then 1.0
        else 0.0
    else
        let den1 = float_of_int @@ knots.(k + d) - knots.(k) in
        let eq1 =
            if den1 > 0.0 then
                ((u -. float_of_int knots.(k)) /. den1) *.
                (cox_deboor knots u k (d - 1))
            else 0.0 in
        let den2 = float_of_int @@ knots.(k + d + 1) - knots.(k + 1) in
        let eq2 =
            if den2 > 0.0 then
                ((float_of_int knots.(k + d + 1) -. u) /. den2) *.
                (cox_deboor knots u (k + 1) (d - 1))
            else 0.0 in
        eq1 +. eq2

let bspline cv n d =
    let dim = List.length @@ List.hd cv in
    let count = List.length cv in
    let ul =
        let f x =
            (x /. (float_of_int n -. 1.0)) *.
            (float_of_int count -. float_of_int d) in
        List.map f @@ List.init n float_of_int in
    let knots =
        Array.concat [ Array.make d 0
                     ; Array.init (count - d + 1) (fun x -> x)
                     ; Array.make d (count - d)
                     ] in
    let sample u =
        if u = float_of_int @@ count - d then last [] cv
        else
            let rec loop k acc = function
                | [] -> acc
                | (c :: cv) ->
                    let cox_deboor = cox_deboor knots u k d in
                    let acc =
                        let iter = (List.map (fun c -> cox_deboor *. c) c) in
                        zip_with (+.) acc iter in
                    loop (k + 1) acc cv in
            loop 0 (List.init dim (fun _ -> 0.0)) cv in
    List.map sample ul

let main () =
    let cv = [ [ 50.0; 25.0;   0.0 ]
             ; [ 59.0; 12.0; (-1.0)]
             ; [ 50.0; 10.0;   1.0 ]
             ; [ 57.0;  2.0;   2.0 ]
             ; [ 40.0;  4.0; (-1.0)]
             ; [ 40.0; 14.0;   0.0 ]
             ] in
    bspline cv 10 3
