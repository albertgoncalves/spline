let rec last default = function
    | [] -> default
    | [x] -> x
    | (_::xs) -> last default xs

let rec zip_with f xs ys = match xs, ys with
    | (x::xs), (y::ys) -> f x y::zip_with f xs ys
    | [], _ | _, [] -> []

let sumf = function
    | (x::xs) -> List.fold_left (+.) x xs
    | [] -> 0.0
