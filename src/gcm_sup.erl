-module(gcm_sup).
-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

-define(LOG(Level, Format, Args),
  lager:Level(Format, Args)).

-spec init([]) -> {ok, {{supervisor:strategy(), 5, 10}, [supervisor:child_spec()]}}.
init([]) ->
  ?LOG(info, "Initializing gcm_sup ~p", [""]),
  Gcm = {gcm, {gcm, start_link, [drawers, "AIzaSyABLkwOwfXrjLzDI_HqEadlNNnWfNwg1rQ"]},
      permanent, 5000, worker, [gcm]} ,
    {ok, {{one_for_one, 10, 100}, [Gcm]}}.

