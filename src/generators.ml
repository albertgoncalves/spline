module P = Printf
module R = Random

let fail_n = P.sprintf "[%s] n must be a positive, non-zero integer"

let char_pts accu ~n ~x_min ~x_max ~y_min ~y_max =
    if n <= 0 then failwith @@ fail_n "char_pts" else
        let rand_x () = x_min +. R.float (x_max -. x_min) in
        let rand_y () = y_min +. R.float (y_max -. y_min) in
        let rec loop n accu =
            if n > 0 then
                loop (n - 1) ([rand_x (); rand_y ()] :: accu)
            else accu in
        loop n accu

let word_pts ~n ~word_start ~word_sep ~char_range ~y_min ~y_max =
    if n <= 0 then failwith @@ fail_n "word_pts" else
        let rec loop n accu =
            if n > 0 then
                let m = 4 + R.int 5 in
                let x_max = word_start +. (float_of_int n *. word_sep) in
                let x_min = x_max -. char_range in
                let pts = char_pts accu ~n:m ~x_min ~x_max ~y_min ~y_max in
                loop (n - 1) pts
            else accu in
        loop n []

let sentence_pts ~ns ~sentence_start ~word_sep ~char_range ~y_min ~y_max =
    let rec loop start accu = function
        | (n::ns) ->
            let next_start = start +. float_of_int n in
            let word =
                word_pts
                    ~n ~word_start:start ~word_sep ~char_range ~y_min ~y_max in
            loop next_start (word::accu) ns
        | [] -> accu in
    loop sentence_start [] ns
