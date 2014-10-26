open Core.Std
open Async.Std

let add host port who value =
  Roshiak.insert
    ~host
    ~port
    ~k:who
    ~t:(Int64.of_float (Time.to_float (Time.now ())))
    ~v:value
  >>| function
    | Ok () ->
      shutdown 0
    | Error _ ->
      shutdown 1

let del host port who value =
  Roshiak.delete
    ~host
    ~port
    ~k:who
    ~t:(Int64.of_float (Time.to_float (Time.now ())))
    ~v:value
  >>| function
    | Ok () ->
      shutdown 0
    | Error _ ->
      shutdown 1

let sel host port who =
  Roshiak.select
    ~host
    ~port
    ~k:who
  >>| function
    | Ok res -> begin
      List.iter
        ~f:(fun (v, t) ->
          printf "%s %s\n" v (Int64.to_string t))
        res;
      shutdown 0
    end
    | Error _ ->
      shutdown 1

let main () =
  match Sys.argv.(1) with
    | "add" ->
      add
        Sys.argv.(2)
        (Int.of_string Sys.argv.(3))
        Sys.argv.(4)
        Sys.argv.(5)
    | "del" ->
      del
        Sys.argv.(2)
        (Int.of_string Sys.argv.(3))
        Sys.argv.(4)
        Sys.argv.(5)
    | "sel" ->
      sel
        Sys.argv.(2)
        (Int.of_string Sys.argv.(3))
        Sys.argv.(4)
    | unknown ->
      failwith ("Unknown command: " ^ unknown)

let () =
  ignore (main ());
  ignore (Scheduler.go ())

