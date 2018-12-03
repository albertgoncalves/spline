module R = Random

let rand_pts n l ~x_min ~x_max ~y_min ~y_max =
    assert (n > 0);
    let rand_x () = x_min +. R.float (x_max -. x_min) in
    let rand_y () = y_min +. R.float (y_max -. y_min) in
    let rec loop n l =
        if n > 0 then
            loop (n - 1) ([rand_x (); rand_y ()] :: l)
        else l in
    loop n l

let word_pts n =
    assert (n > 0);
    let rec loop accu n =
        if n > 0 then
            let m = 4 + R.int 5 in
            let x_max = float_of_int n in
            let x_min = x_max -. 1.0 in
            let pts = rand_pts m accu ~x_min ~x_max ~y_min:0.0 ~y_max:1.0 in
            loop pts (n - 1)
        else accu in
    loop [] n
