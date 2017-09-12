-module(electrolink_cloud_status).

-export([init/2]).

init(Req, Opts) ->
    Req2 = cowboy_req:reply(200,
		#{<<"content-type">> => <<"application/json">>},
        jsx:encode([{<<"status">>,<<"running">>}]),
        Req),
    {ok, Req2, Opts}.
