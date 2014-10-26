open Core.Std
open Async.Std

val insert :
  host:string ->
  port:int ->
  k:string ->
  t:Int64.t ->
  v:string ->
  (unit, [> Riakc.Opts.Put.error ]) Deferred.Result.t

val delete :
  host:string ->
  port:int ->
  k:string ->
  t:Int64.t ->
  v:string ->
  (unit, [> Riakc.Opts.Put.error ]) Deferred.Result.t

val select :
  host:string ->
  port:int ->
  k:string ->
  ((string * Int64.t) list, [> Riakc.Conn.error ]) Deferred.Result.t

