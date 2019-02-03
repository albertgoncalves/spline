module L = List

let rec last default = function
    | [] -> default
    | [x] -> x
    | (_::xs) -> last default xs

let rec zip_with f xs ys = match xs, ys with
    | [], _ | _, [] -> []
    | (x::xs), (y::ys) -> f x y::zip_with f xs ys

let sum_int = function
    | [] -> 0
    | (x::xs) -> L.fold_left (+) x xs
