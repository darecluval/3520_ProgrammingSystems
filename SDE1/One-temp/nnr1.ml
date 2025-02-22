(* SDE1
 * Clare DuVal
 * CPSC 3520
 *)

 (* data for simple 4 class case *)

 open List;;

 let simpleH = [[5.;5.;1.];[5.;-5.;2.];[-5.;-5.;3.];[-5.;5.;4.]];;

 (* some test vectors *)

 let t1 = [3.;3.;0.];;
 let t2 = [-1.;-1.;0.];;
 let t3 = [0.;0.;0.];;
 let t4 = [-1.;1.;0.];;
 let t5 = [0.;-1.;0.];;

 (* larger dataset *)

 let wcdata = [
 [3.26495e+02; 6.00000e+00; 2.82447e+02; 1.10000e+01; -3.61804e+01; -1.17557e+01; 1.];
 [5.19186e+02; 1.00000e+00; 4.57228e+01; 4.70000e+01; -3.61804e+01; -1.17557e+01; 1.];
 [7.03244e+01; 5.00000e+00; 2.15593e+01; 2.80000e+01; -2.23607e+01; 3.07768e+01; 1.];
 [1.87247e+02; 1.00000e+00; 7.03097e+01; 1.80000e+01; -2.23607e+01; 3.07768e+01; 1.];
 [4.26179e+02; 6.00000e+00; 1.33301e+02; 2.20000e+01; 3.61804e+01; 1.17557e+01; 7.];
 [1.97036e+03; 5.00000e+00; 7.51209e+02; 1.90000e+01; 3.11803e+01; 1.90212e+01; 7.];
 [1.28191e+03; 1.00000e+00; 6.08078e+02; 2.20000e+01; 1.78214e+01; 1.08487e+01; 7.];
 [4.82068e+02; 4.00000e+00; 4.71010e+02; 2.00000e+01; -2.23607e+01; 3.07768e+01; 1.];
 [9.24921e+02; 7.00000e+00; 3.40959e+02; 1.60000e+01; 3.61804e+01; 1.17557e+01; 1.];
 [4.85993e+02; 7.00000e+00; 3.91866e+02; 2.10000e+01; -2.23607e+01; 3.07768e+01; 1.];
 [1.85204e+02; 4.00000e+00; 5.22527e+01; 2.40000e+01; -2.23607e+01; 3.07768e+01; 5.];
 [2.54153e+02; 2.40000e+01; 1.86337e+02; 1.00000e+00; 1.40018e+01; 2.98699e+01; 5.];
 [3.08718e+02; 1.00000e+01; 1.56700e+02; 2.00000e+01; -2.23607e+01; -3.07768e+01; 5.];
 [1.28083e+02; 8.00000e+00; 1.33937e+01; 5.40000e+01; 0.00000e+00; -1.00000e+01; 4.];
 [1.44025e+02; 6.00000e+00; 2.34110e+01; 1.60000e+01; -2.23607e+01; 3.07768e+01; 4.];
 [1.90704e+02; 6.00000e+00; 2.35136e+01; 1.80000e+01; 1.40018e+01; -2.98699e+01; 4.];
 [1.74306e+02; 1.20000e+01; 5.55195e+01; 2.20000e+01; -1.40018e+01; -2.98699e+01; 5.];
 [2.01648e+02; 1.00000e+00; 1.35576e+02; 4.90000e+01; 3.61804e+01; -1.17557e+01; 5.];
 [5.38501e+01; 6.00000e+00; 4.88364e+01; 2.50000e+01; 0.00000e+00; -1.00000e+01; 5.];
 [1.50294e+02; 7.00000e+00; 2.42179e+01; 2.40000e+01; 0.00000e+00; -1.00000e+01; 5.]];;

 (* some vectors for testing *)

 let tvc1 = [98.641683; 17.0; 75.387416; 9.0; -36.18035; 11.7557; 0.];;

 let tvc2 = [1869.2331; 5.0; 184.885; 27.0; 17.82145; 10.8487; 0.];;

 let tvc3 = List.nth wcdata 1;;  (* class = 1. *)

 let tvc4 = List.nth wcdata 4;;    (* class = 7. *)

 let tvc5 = List.nth wcdata 10;;   (* class = 5. *)

 let tvc6 = List.nth wcdata 7;;   (* class = 1. *)

 let tvc7 = List.nth wcdata 13;;   (* class = 4. *)



(* Helper functions *)
(*val printIt : float list -> unit = <fun>*)
let rec printIt = function
  [] -> ()
  | x::y -> print_float x ; print_string " " ; printIt y;;

(*val prepend : 'a list -> 'a -> 'a list = <fun>*)
let rec prepend a x =
  match a with
  [] -> [x]
  | x1::x2 -> x::(prepend x2 x1);;

(*val least : 'a list -> 'a = <fun>*)
let rec least x =
  match x with
  [] -> failwith "Empty list"
  | [x] -> x
  | x1::x2 ->
    let y = least x2 in
      if x1 < y then
        x1
      else
        y;;

(*val find : 'a -> 'a list -> int = <fun>*)
let rec find x a =
  match a with
  [] -> -1
  | x1::x2 -> if x = x1 then 0
      else 1 + find x x2;;

(*val getIDX : int -> 'a list -> 'a = <fun>*)
let rec getIDX x a =
  match x, a with
  _, [] -> failwith "Empty list"
  | 0, a::_ -> a
  | x, x1::x2 -> getIDX (x-1) x2;;

(* 1: printList Function *)
(*val printList : float list list -> unit = <fun>*)
let rec printList = function
  [] -> ()
  | x::y -> printIt x ; print_string "\n" ; printList y;;

(* 2: theClass Function *)
(*val theClass: 'a list -> 'a = <fun>*)
let rec theClass = function
  [] -> failwith "No class found."
  | [x] -> x
  | x::y -> theClass y;;

(* 3: distanceR2 Function *)
(*val distanceR2 : float list * float list -> float = <fun>*)
let rec distanceR2 x y =
  match x, y with
  | [x], [y] -> distanceR2 [] []
  | x1::x2, y1::y2 -> (y1 -. x1)**2. +. distanceR2 x2 y2
  | _ -> 0.;;

(* 4: distanceAllVectors2 Function *)
(*val distanceAllVectors2 : float list * float list list -> float list = <fun>*)
let rec distanceAllVectors2 x y =
  match x, y with
  | _, [] -> []
  | x, [y] -> prepend [] (distanceR2 x y)
  | x, y1::y2 -> prepend (distanceAllVectors2 x y2) (distanceR2 x y1);;

(* 5: nnr1 Function *)
(*val nnr1 : float list * float list list -> float = <fun>*)
(* 5: nnr1 Function *)
(*val nnr1 : float list * float list list -> float = <fun>*)
let nnr1 x y =
  match x, y with
  | _, [] -> 0.
  | x, y1::y2 -> theClass (getIDX (find (least (distanceAllVectors2 x y)) (distanceAllVectors2 x y)) y);;

  (** script for grading SDE1 SSII 2019  *)

  (** prior to invoking this script, check for legal code as per grading sheet *)

  (** also prior to invoking this script,
      start and log an ocaml session
      via:
             script -c ocaml <studentname>-sde1.log
      then
            #use"sde1_testing.caml" and
            #quit;;
  *)

  open List;;   (* just to be sure List module functions are available *)

  (** get student work, compile and check *)
  (*print_string ("\n\n++++++++++Loading Student file:nnr1.caml+++++++++++\n\n");;
  #use"nnr1.caml";;*)

  (** get testing data *)
  (*#use"./sde1_grading_data.caml";;*)

  (** exercise the functions *)
  (** simple functions *)
  (* give each returned function value a name for grading *)
  (*print_string ("\n\n++++++++++Testing Functions+++++++++++++++\n\n");;*)

  print_string "1: ";;

  print_float (theClass t1) ;;

  print_string "\n2: ";;

  printList simpleH;;

  print_string "\n3: ";;

  printList wcdata;;

  print_string "\n4: ";;

  print_float (distanceR2 [1.;2.;0.] [5.;5.;0.]);;

  print_string "\n5: ";;

  print_float (distanceR2 t1 t3);;

  print_string "\n6: ";;

  printIt (distanceAllVectors2 [5.;5.;0.] simpleH);;

  print_string "\n7: ";;

  printIt (distanceAllVectors2 [-25.;1.;0.] simpleH);;

  print_string "\n8: ";;

  print_float (nnr1 [-25.;1.;0.] simpleH) ;;

  print_string "\n9: ";;

  print_float (nnr1 [25.;-1.;0.] simpleH) ;;

  print_string "\n10: ";;

  (** not so simple functions (and data) *)

  print_float (distanceR2 tvc3 tvc4) ;;

  print_string "\n11: ";;

  printIt (distanceAllVectors2 tvc4 wcdata) ;;

  print_string "\n12: ";;

  printIt (distanceAllVectors2 tvc6 wcdata) ;;

  print_string "\n13: ";;

  print_float (nnr1 tvc1 wcdata) ;;

  print_string "\n14: ";;

  print_float (nnr1 tvc2 wcdata) ;;

  print_string "\n15: ";;

  print_float (nnr1 tvc3 wcdata) ;;

  print_string "\n16: ";;

  print_float (nnr1 tvc4 wcdata) ;;

  print_string "\n17: ";;

  print_float (nnr1 tvc5 wcdata) ;;

  print_string "\n18: ";;

  print_float (nnr1 tvc6 wcdata) ;;

  print_string "\n19: ";;

  print_float (nnr1 tvc7 wcdata) ;;

  print_string "\n20: ";;

  print_float (nnr1 [0.0;0.0;0.0;0.0;0.0;0.0;0.0] wcdata) ;;
