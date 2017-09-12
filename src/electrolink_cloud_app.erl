%%%-------------------------------------------------------------------
%% @doc electrolink_cloud public API
%% @end
%%%-------------------------------------------------------------------

-module(electrolink_cloud_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, Pid} = 'electrolink_cloud_sup':start_link(),
	Routes = [ {
        '_',
        [
            {"/status", electrolink_cloud_status, []},
            {"/user", electrolink_cloud_user, []},
            {"/login", electrolink_cloud_login, []}
        ]
    } ],
    Dispatch = cowboy_router:compile(Routes),

    TransOpts = [ {ip, {0,0,0,0}}, {port, 8089} ],
	ProtoOpts = #{env => #{dispatch => Dispatch}},

	{ok, _} = cowboy:start_clear(my_cowboy,
		TransOpts, ProtoOpts),

    {ok, Pid}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
