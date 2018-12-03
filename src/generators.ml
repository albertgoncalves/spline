module R = Random

let char_pts n l ~x_min ~x_max ~y_min ~y_max =
    assert (n > 0);
    let rand_x () = x_min +. R.float (x_max -. x_min) in
    let rand_y () = y_min +. R.float (y_max -. y_min) in
    let rec loop n l =
        if n > 0 then
            loop (n - 1) ([rand_x (); rand_y ()] :: l)
        else l in
    loop n l

let word_pts n ~word_start ~word_sep ~char_range ~y_min ~y_max =
    assert (n > 0);
    let rec loop accu n =
        if n > 0 then
            let m = 4 + R.int 5 in
            let x_max = word_start +. (float_of_int n *. word_sep) in
            let x_min = x_max -. char_range in
            let pts = char_pts m accu ~x_min ~x_max ~y_min ~y_max in
            loop pts (n - 1)
        else accu in
    loop [] n
