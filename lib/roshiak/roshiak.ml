open Core.Std
open Async.Std

module Roshi_set = struct
  type score = Int64.t with sexp
  type 'a t = { adds : score String.Map.t
              ; dels : score String.Map.t
              } with sexp

  let update value score m =
    match Map.find m value with
      | Some score' when Int64.(score' > score) ->
        m
      | Some _
      | None ->
        Map.add ~key:value ~data:score m

  let create () = { adds = String.Map.empty
                  ; dels = String.Map.empty
                  }

  let add ~v ~s t =
    { t with adds = update v s t.adds }

  let del ~v ~s t =
    { t with dels = update v s t.dels }

  let merge t1 t2 =
    let m =
      Map.fold
        ~f:(fun ~key ~data m ->
          update key data m)
    in
    { adds = m ~init:t1.adds t2.adds
    ; dels = m ~init:t1.dels t2.dels
    }

  let to_list t =
    let m =
      Map.fold
        ~init:t.adds
        ~f:(fun ~key ~data m ->
          match Map.find m key with
            | Some score when Int64.(score < data) ->
              Map.remove m key
            | Some _
            | None ->
              m)
        t.dels
    in
    Map.to_alist m
end

let bucket = "roshiak"

let robj_of_res = function
  | Error _ -> begin
    let module R = Riakc.Robj in
    Roshi_set.create ()
    |> Roshi_set.sexp_of_t String.sexp_of_t
    |> Sexp.to_string
    |> R.Content.create
    |> R.create
    |> (fun robj -> R.set_contents (R.contents robj) robj)
  end
  | Ok robj ->
    robj

let merge_contents contents =
  List.fold_left
    ~f:(fun rset content ->
      let module R = Riakc.Robj in
      R.Content.value content
      |> Sexp.of_string
      |> Roshi_set.t_of_sexp String.t_of_sexp
      |> Roshi_set.merge rset)
    ~init:(Roshi_set.create ())
    contents

let update ~host ~port ~k ~t ~v f =
  Riakc.Conn.with_conn
    ~host
    ~port
    (fun c ->
      let module R = Riakc.Robj in
      Riakc.Conn.get c ~b:bucket k
      >>= fun res ->
      let robj = robj_of_res res in
      let contents = R.contents robj in
      let rset = f ~v ~s:t (merge_contents contents) in
      let robj =
        rset
        |> Roshi_set.sexp_of_t String.sexp_of_t
        |> Sexp.to_string
        |> R.Content.create
        |> Fn.flip R.set_content robj
      in
      Riakc.Conn.put c ~b:bucket ~k robj
      >>=? fun _ ->
      Deferred.return (Ok ()))


let insert ~host ~port ~k ~t ~v =
  update ~host ~port ~k ~t ~v Roshi_set.add

let delete ~host ~port ~k ~t ~v =
  update ~host ~port ~k ~t ~v Roshi_set.del

let select ~host ~port ~k =
  Riakc.Conn.with_conn
    ~host
    ~port
    (fun c ->
      let module R = Riakc.Robj in
      Riakc.Conn.get c ~b:bucket k
      >>= fun res ->
      let robj = robj_of_res res in
      let rset = merge_contents (R.contents robj) in
      Deferred.return (Ok (Roshi_set.to_list rset)))

