--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.8 (Ubuntu 15.8-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.account_emailaddress ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.account_emailconfirmation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_site ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_chatmessage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_chatmessage (
    id bigint NOT NULL,
    content text NOT NULL,
    sent_at timestamp with time zone NOT NULL,
    receiver_id integer NOT NULL,
    sender_id integer NOT NULL
);


ALTER TABLE public.main_chatmessage OWNER TO postgres;

--
-- Name: main_chatmessage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_chatmessage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_chatmessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_comment (
    id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    commented_by_id integer NOT NULL,
    note_id bigint,
    question_id bigint
);


ALTER TABLE public.main_comment OWNER TO postgres;

--
-- Name: main_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_comment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_note (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    auto_slug character varying(255) NOT NULL,
    uploaded_by_id integer NOT NULL
);


ALTER TABLE public.main_note OWNER TO postgres;

--
-- Name: main_note_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_note_topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_note_topics (
    id bigint NOT NULL,
    note_id bigint NOT NULL,
    topic_id bigint NOT NULL
);


ALTER TABLE public.main_note_topics OWNER TO postgres;

--
-- Name: main_note_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_note_topics ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_note_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_question (
    id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    auto_slug character varying(255) NOT NULL,
    added_by_id integer NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE public.main_question OWNER TO postgres;

--
-- Name: main_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_question ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_question_topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_question_topics (
    id bigint NOT NULL,
    question_id bigint NOT NULL,
    topic_id bigint NOT NULL
);


ALTER TABLE public.main_question_topics OWNER TO postgres;

--
-- Name: main_question_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_question_topics ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_question_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_subject (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    auto_slug character varying(255) NOT NULL
);


ALTER TABLE public.main_subject OWNER TO postgres;

--
-- Name: main_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_subject ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_topic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_topic (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    auto_slug character varying(255) NOT NULL,
    subject_id bigint NOT NULL
);


ALTER TABLE public.main_topic OWNER TO postgres;

--
-- Name: main_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_topic ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: main_userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.main_userprofile (
    id bigint NOT NULL,
    bio text,
    pfp character varying(255),
    user_id integer NOT NULL
);


ALTER TABLE public.main_userprofile OWNER TO postgres;

--
-- Name: main_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.main_userprofile ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.main_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(200) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data jsonb NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.socialaccount_socialaccount ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL,
    provider_id character varying(200) NOT NULL,
    settings jsonb NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.socialaccount_socialapp ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id bigint NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.socialaccount_socialapp_sites ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.socialaccount_socialtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    id bigint NOT NULL,
    topic text NOT NULL,
    extension text NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE realtime.messages_id_seq OWNER TO supabase_realtime_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.messages_id_seq OWNED BY realtime.messages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER TABLE vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ALTER COLUMN id SET DEFAULT nextval('realtime.messages_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
1	siddharthgreat443@gmail.com	t	t	2
2	dalerjatt5911@gmail.com	t	t	3
3	abhishekbisht0203@gmail.com	t	t	4
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add subject	7	add_subject
26	Can change subject	7	change_subject
27	Can delete subject	7	delete_subject
28	Can view subject	7	view_subject
29	Can add chat message	8	add_chatmessage
30	Can change chat message	8	change_chatmessage
31	Can delete chat message	8	delete_chatmessage
32	Can view chat message	8	view_chatmessage
33	Can add note	9	add_note
34	Can change note	9	change_note
35	Can delete note	9	delete_note
36	Can view note	9	view_note
37	Can add question	10	add_question
38	Can change question	10	change_question
39	Can delete question	10	delete_question
40	Can view question	10	view_question
41	Can add comment	11	add_comment
42	Can change comment	11	change_comment
43	Can delete comment	11	delete_comment
44	Can view comment	11	view_comment
45	Can add topic	12	add_topic
46	Can change topic	12	change_topic
47	Can delete topic	12	delete_topic
48	Can view topic	12	view_topic
49	Can add user profile	13	add_userprofile
50	Can change user profile	13	change_userprofile
51	Can delete user profile	13	delete_userprofile
52	Can view user profile	13	view_userprofile
53	Can add email address	14	add_emailaddress
54	Can change email address	14	change_emailaddress
55	Can delete email address	14	delete_emailaddress
56	Can view email address	14	view_emailaddress
57	Can add email confirmation	15	add_emailconfirmation
58	Can change email confirmation	15	change_emailconfirmation
59	Can delete email confirmation	15	delete_emailconfirmation
60	Can view email confirmation	15	view_emailconfirmation
61	Can add social account	16	add_socialaccount
62	Can change social account	16	change_socialaccount
63	Can delete social account	16	delete_socialaccount
64	Can view social account	16	view_socialaccount
65	Can add social application	17	add_socialapp
66	Can change social application	17	change_socialapp
67	Can delete social application	17	delete_socialapp
68	Can view social application	17	view_socialapp
69	Can add social application token	18	add_socialtoken
70	Can change social application token	18	change_socialtoken
71	Can delete social application token	18	delete_socialtoken
72	Can view social application token	18	view_socialtoken
73	Can add site	19	add_site
74	Can change site	19	change_site
75	Can delete site	19	delete_site
76	Can view site	19	view_site
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
3	!kB9QCBkVpXRHoa4pOVL0RT6Z9MSHD4VVXzdFjwgI	2024-09-11 12:19:21.799357+00	f	daler	daler	jatt	dalerjatt5911@gmail.com	f	t	2024-09-11 12:19:17.892691+00
1	pbkdf2_sha256$870000$1o1O0duVxV8C8ApLkoiZqV$KV5WuSKHWIy2TrOlSdxWQk9NJkKt0hKRrk9axp1Xdzs=	2024-09-17 17:56:57.858613+00	t	Siddharth				t	t	2024-08-29 18:48:28.93717+00
2	!bDmfzbTBH6UlZzWdtBCAeRMtdN2c6xw4TYooMuta	2024-09-23 04:32:11.735631+00	t	siddharth7	Siddharth	Tiwari	siddharthgreat443@gmail.com	t	t	2024-09-10 19:49:08+00
4	!yYUXZpUBqp3lX2GORyRshdLVGcT3qRdm3CsV8VoW	2024-09-23 13:38:06.676697+00	f	abhishek	Abhishek	Bisht	abhishekbisht0203@gmail.com	f	t	2024-09-23 13:38:02.818184+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-09-01 16:13:05.977718+00	2	Data Science	3		7	1
2	2024-09-01 17:03:40.755969+00	1	Django	3		7	1
3	2024-09-01 18:24:50.496477+00	4	Web Design	3		7	1
4	2024-09-02 18:58:06.062618+00	3	📡 Live Chat with Django Channels: A Fun Guide	2	[{"changed": {"fields": ["Content"]}}]	9	1
5	2024-09-02 19:02:55.942261+00	3	📡 Live Chat with Django Channels: A Fun Guide	2	[{"changed": {"fields": ["Content"]}}]	9	1
6	2024-09-02 19:26:42.838446+00	1	# 📊 Pandas Practice Questions\r\n\r\n## **Basic Operat	1	[{"added": {}}]	10	1
7	2024-09-05 17:50:13.84911+00	1	Google	1	[{"added": {}}]	17	1
8	2024-09-05 18:22:58.978513+00	1	12	2	[{"changed": {"fields": ["Domain name"]}}]	19	1
9	2024-09-05 18:23:13.575839+00	1	127.0.0.1:8000	2	[{"changed": {"fields": ["Domain name", "Display name"]}}]	19	1
10	2024-09-05 18:23:24.658477+00	1	127.0.0.1:8000	2	[{"changed": {"fields": ["Display name"]}}]	19	1
11	2024-09-05 18:23:46.539171+00	1	Google	1	[{"added": {}}]	17	1
12	2024-09-05 18:35:04.239359+00	1	http://127.0.0.1:8000	2	[{"changed": {"fields": ["Domain name", "Display name"]}}]	19	1
13	2024-09-05 18:35:27.187672+00	1	Google	2	[]	17	1
14	2024-09-06 19:22:14.56483+00	1	127.0.0.1:8000	2	[{"changed": {"fields": ["Domain name", "Display name"]}}]	19	1
15	2024-09-09 18:11:34.18329+00	1	localhost	2	[{"changed": {"fields": ["Domain name", "Display name"]}}]	19	1
16	2024-09-09 18:12:51.067667+00	1	Google	2	[{"changed": {"fields": ["Key"]}}]	17	1
17	2024-09-10 20:37:08.853291+00	2	Github	1	[{"added": {}}]	17	1
18	2024-09-17 17:58:44.543584+00	2	siddharth7	2	[{"changed": {"fields": ["Staff status", "Superuser status"]}}]	4	1
19	2024-09-17 17:59:41.990443+00	11	jQuery AJAX	2	[{"changed": {"fields": ["Topics"]}}]	9	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	main	subject
8	main	chatmessage
9	main	note
10	main	question
11	main	comment
12	main	topic
13	main	userprofile
14	account	emailaddress
15	account	emailconfirmation
16	socialaccount	socialaccount
17	socialaccount	socialapp
18	socialaccount	socialtoken
19	sites	site
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-08-29 18:47:58.183139+00
2	auth	0001_initial	2024-08-29 18:48:00.636945+00
3	admin	0001_initial	2024-08-29 18:48:01.277371+00
4	admin	0002_logentry_remove_auto_add	2024-08-29 18:48:01.372602+00
5	admin	0003_logentry_add_action_flag_choices	2024-08-29 18:48:01.606156+00
6	contenttypes	0002_remove_content_type_name	2024-08-29 18:48:02.356862+00
7	auth	0002_alter_permission_name_max_length	2024-08-29 18:48:02.678305+00
8	auth	0003_alter_user_email_max_length	2024-08-29 18:48:02.958545+00
9	auth	0004_alter_user_username_opts	2024-08-29 18:48:03.126431+00
10	auth	0005_alter_user_last_login_null	2024-08-29 18:48:03.517833+00
11	auth	0006_require_contenttypes_0002	2024-08-29 18:48:03.675806+00
12	auth	0007_alter_validators_add_error_messages	2024-08-29 18:48:03.9277+00
13	auth	0008_alter_user_username_max_length	2024-08-29 18:48:04.282406+00
14	auth	0009_alter_user_last_name_max_length	2024-08-29 18:48:04.597938+00
15	auth	0010_alter_group_name_max_length	2024-08-29 18:48:04.917743+00
16	auth	0011_update_proxy_permissions	2024-08-29 18:48:05.081323+00
17	auth	0012_alter_user_first_name_max_length	2024-08-29 18:48:05.478226+00
18	main	0001_initial	2024-08-29 18:48:08.748252+00
19	sessions	0001_initial	2024-08-29 18:48:09.197379+00
20	main	0002_alter_comment_commented_by_userprofile	2024-09-02 04:51:13.101255+00
21	main	0003_alter_userprofile_pfp	2024-09-02 17:13:29.644881+00
22	main	0004_rename_question_text_question_content_question_title	2024-09-03 17:31:29.911463+00
23	main	0005_alter_question_auto_slug	2024-09-03 17:55:10.790439+00
24	account	0001_initial	2024-09-05 17:40:09.596156+00
25	account	0002_email_max_length	2024-09-05 17:40:09.793496+00
26	account	0003_alter_emailaddress_create_unique_verified_email	2024-09-05 17:40:10.588216+00
27	account	0004_alter_emailaddress_drop_unique_email	2024-09-05 17:40:11.242429+00
28	account	0005_emailaddress_idx_upper_email	2024-09-05 17:40:12.019807+00
29	account	0006_emailaddress_lower	2024-09-05 17:40:12.633617+00
30	account	0007_emailaddress_idx_email	2024-09-05 17:40:13.070437+00
31	account	0008_emailaddress_unique_primary_email_fixup	2024-09-05 17:40:13.310727+00
32	account	0009_emailaddress_unique_primary_email	2024-09-05 17:40:13.585644+00
41	sites	0001_initial	2024-09-05 18:20:01.19056+00
42	sites	0002_alter_domain_unique	2024-09-05 18:20:01.582115+00
43	socialaccount	0001_initial	2024-09-05 18:20:09.33594+00
44	socialaccount	0002_token_max_lengths	2024-09-05 18:20:09.817772+00
45	socialaccount	0003_extra_data_default_dict	2024-09-05 18:20:09.996054+00
46	socialaccount	0004_app_provider_id_settings	2024-09-05 18:20:10.749918+00
47	socialaccount	0005_socialtoken_nullable_app	2024-09-05 18:20:11.377748+00
48	socialaccount	0006_alter_socialaccount_extra_data	2024-09-05 18:20:11.749385+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
v37j4fcep7cq8jyprci1e2ff1s4plr9b	.eJxVjEsOwiAUAO_C2hAoD3i4dN8zED4PqRqalHZlvLsh6UK3M5N5Mx-Ovfqj0-aXzK5MsssviyE9qQ2RH6HdV57Wtm9L5CPhp-18XjO9bmf7N6ih17ElSBpt1kWL4MgSAmoptUABVhhQKas8EU7COAeySGWsLkgRVFSOHPt8AbcaNp0:1sjkCM:o_AsH4_imTo09_kd6BkOGebsfpIc1ZsG64DTwa8fedo	2024-09-12 18:48:46.44611+00
drupvcjp15g7w9u2uvz91uqfybb8lqh1	.eJxVjEsOwiAUAO_C2hAoD3i4dN8zED4PqRqalHZlvLsh6UK3M5N5Mx-Ovfqj0-aXzK5MsssviyE9qQ2RH6HdV57Wtm9L5CPhp-18XjO9bmf7N6ih17ElSBpt1kWL4MgSAmoptUABVhhQKas8EU7COAeySGWsLkgRVFSOHPt8AbcaNp0:1sknAL:vHn0NdWxJoxiJ6fLqRxl8WGHGRSk-HQ_MaF_gG80dHw	2024-09-15 16:11:01.882754+00
w0kaqxp6fsmke9izvdel3nnz3iclhqvy	.eJxVjEsOwiAUAO_C2hAoD3i4dN8zED4PqRqalHZlvLsh6UK3M5N5Mx-Ovfqj0-aXzK5MsssviyE9qQ2RH6HdV57Wtm9L5CPhp-18XjO9bmf7N6ih17ElSBpt1kWL4MgSAmoptUABVhhQKas8EU7COAeySGWsLkgRVFSOHPt8AbcaNp0:1slA7C:j-NebwAm0y-E3-BpMYXYyt6YrtTzI3jN9nwZcYXQ3HA	2024-09-16 16:41:18.888619+00
u57rizadi482jjq33frulzw8cfdhj97w	.eJxVjEsOwiAUAO_C2hAoD3i4dN8zED4PqRqalHZlvLsh6UK3M5N5Mx-Ovfqj0-aXzK5MsssviyE9qQ2RH6HdV57Wtm9L5CPhp-18XjO9bmf7N6ih17ElSBpt1kWL4MgSAmoptUABVhhQKas8EU7COAeySGWsLkgRVFSOHPt8AbcaNp0:1slAP6:mxqMshtpd30tI_2QnmgYsndw8bRiL4HXrZxWHbIVTJA	2024-09-16 16:59:48.654725+00
o77bj2w820ti98h0epeuuasusv55lvvg	.eJxVT8tuhSAQ_ZdZG8OADOiu_Y2mMQjTq6mVRrAbc_-9aO3C3cmZ85odUvSTm533cVtyn7LLnKDbnxX8c27LIy958i5Pcem_OI8xFM3bDn8YunsKFG-GDo00QmlLtiYUQqkKvtf4MwVei-MR42PmIt2mIwDRNkIZ0bTUSl2AQa3h-V7B2d9vidf-VEq4cYPzn7wcBzfPB11fK-pTc51T_XL74vVy3aJGl8ajgBBbq7QMLJCMJiQKTquAg7XIg_mw7IWSkpRqAksXyHJwLISnZuCy-hdPbW-T:1ssSvG:skWi9eASjavE-I2VRnR-HI9Lr5k07zQN1qqaPZKv2fk	2024-10-06 20:11:10.148371+00
jy2ps9i9f1miehj7cjrcbpbwv0z82pf4	.eJxVjEsOwiAUAO_C2hAoD3i4dN8zED4PqRqalHZlvLsh6UK3M5N5Mx-Ovfqj0-aXzK5MsssviyE9qQ2RH6HdV57Wtm9L5CPhp-18XjO9bmf7N6ih17ElSBpt1kWL4MgSAmoptUABVhhQKas8EU7COAeySGWsLkgRVFSOHPt8AbcaNp0:1smGbc:vyr60Hd04oKpXKaI0D0alZvfKGCl7OJusZMtltCXltQ	2024-09-19 17:49:16.063313+00
05ulyu45ofdd2zq50961ojgzlsbt5lar	.eJxVT8tOhTAQ_ZdZE9J3Czv9DWPI0I6XRqSGFjfk_rsFccHu5LzmzA45-Ygzep-2pQy5YKEM_f5s4J_DrUy0lOixxLQMX1SmFKrnbYc_DP29BWq2QM-tsMzoTrJWcaOsUw18r-knBlpr5JHSY6bq3eLRwLlTTFqmOtMJXYHlWsPzvYFzwLBlWofTKeDGjeg_aTkEnOeDbq8Z7em55Ny-3N54vVK3qgnzdBwwnHdOahGIcWO14cYE1DLw0TlOo_1w5JkUwkipAgkMxlFAYswbNVJd_Qut8W_R:1ssak7:tHYP2IMRQN7cRA9BJI_OeMwThptaF483uU6EKTvSA60	2024-10-07 04:32:11.928078+00
3vykcr3o1xsvfiagvyxk5hghu8bw6bcq	.eJxVjMEOgyAQRP9lz8YooKK39kfIuqyRlGIi0Ivx36uNPXicNzNvg7iQQ49ESw7JxISJIwzbXsCffXh1k2Nr-I3OwxCy9wUYzGk2OfJqnIUBFNzYiPTicBbo_YnLS1f-Nlcdy8eROCRHmNwSntfrppoxzoeHVWcliZ6VGEnVQmvbyJGl6Eg2aFWrkLDGsZqUnLTQbSW0rRibuq-lbhvYv0jwUT4:1ssjGR:aPvyyzBfdAY231Rzxe9xX8I134dABUHTZk3WyjzOMwU	2024-10-07 13:38:07.080049+00
juoa9drys39hrdtj7z4jmxc6mutfat9b	.eJxVjEsOwiAUAO_C2hAoD3i4dN8zED4PqRqalHZlvLsh6UK3M5N5Mx-Ovfqj0-aXzK5MsssviyE9qQ2RH6HdV57Wtm9L5CPhp-18XjO9bmf7N6ih17ElSBpt1kWL4MgSAmoptUABVhhQKas8EU7COAeySGWsLkgRVFSOHPt8AbcaNp0:1sniqx:Zm9N19sBN5ZpHB_KtMLrtzNpi8H5LxW3zp4AVwgj1hA	2024-09-23 18:11:07.387696+00
43gquxhfcsgae6crxx5jdm3sra6ia8gu	.eJxVjctugzAQRf9l1gjZxJjHrtlnFambqrKG8VAsHBNh00UR_17SkkWWc8-dc1eIEzn0SDQtIZmYMHGEdoV04SvexPviTtfx9HOG9mOF-zwRx52Dn75cgAwsJoQ2LN5ncB-JDU2WzTfPrnc8_5Mtk1WhRVlJpXPVCKmb8nPL4Dl6tK3hGzr_tBlc0mCWyLNxdl88wUvWIY0cHgC9f8T5ocv_OgeO-dt-cUiOMLkpnI-vF9WAcdg9rHpZY6drrnXTaUQhmdlaKlRTUtdgIavKVlZxxcpKLXorukZZQX3HVBBsvy8sck4:1soMJe:5vO6VKhJwN0HcxPPvZp_xzvbZ51xWj_H5OpFCN9021k	2024-09-25 12:19:22.289793+00
5n19gxnuliqanp0j1t8ao8tv24rck63v	.eJxtkctu4zAMRf9Fa8OwYyl-LGc_q1kWhUBLtK2JIgWS3DQI8u-lXPcFdGWK94CXvL4zUMqvLklY04IuGQXJeCfPmBavIxue7uy9ZgO7QIxXHzQrGCQ21O3hKHrR9rzkdS-4KNgaMTg4I8H_jNYLhLSwx3PxaWP9bBwb7hspLycCaxqHZzBWvmAw074BCWdwGpIPNwKimd16YcMENmLBAmoTUCW5BssGt1q7z_h4ZB6sPF0hzPGzmSBhNqdixpirbR853qTyepPIEej7KNhC9hbp7hRWpPe23U3uNl8kSWoNgcKjnX9AWTLOJEO2Wv4SWXMgQkaMMWeOrxdDxw4V9fLvkFtGRu8ZfeuNoE7osqD_g5t9qbxLwYxlRspdjeVfusn-2dkfAxaISx6LXImu1WISFfTYYsc7Udei6ireVkfeKN3oA3aH6tj3vJ7q5tiKqcORN2PTY88eb7v0wtw:1sqcRe:9b6lStwrLT6Unj9SapHwn1O8UnHpaS2_LZ1vDDhWWGM	2024-10-01 17:56:58.054459+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	localhost	localhost
\.


--
-- Data for Name: main_chatmessage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_chatmessage (id, content, sent_at, receiver_id, sender_id) FROM stdin;
\.


--
-- Data for Name: main_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_comment (id, content, created_at, commented_by_id, note_id, question_id) FROM stdin;
\.


--
-- Data for Name: main_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_note (id, title, content, created_at, auto_slug, uploaded_by_id) FROM stdin;
1	📘 Introduction to Django	## What is Django? 🌐\r\n\r\n**Django** is a high-level Python web framework that promotes rapid development and clean, pragmatic design. Created by experienced developers, Django takes care of much of the hassle of web development, allowing you to focus on writing your app without needing to reinvent the wheel. 🚀\r\n\r\n### Key Features of Django 🏆\r\n\r\n1. **DRY Principle**: Django follows the "Don't Repeat Yourself" principle, which means you write less code and get more functionality! 🙌\r\n2. **Batteries Included**: It comes with numerous built-in features like user authentication, admin panels, and database ORM (Object-Relational Mapping) to make your life easier. ⚙️\r\n3. **Security**: Django provides strong security features like protection against SQL injection, cross-site scripting, cross-site request forgery, and more. 🛡️\r\n4. **Scalability**: It is designed to handle the heaviest of traffic demands, so your app can scale as needed. 📈\r\n5. **Versatile**: Django is used for all kinds of web applications, from content management systems (CMS) to social networks, to scientific computing platforms. 🌍\r\n\r\n## Understanding the Django Architecture 🏗️\r\n\r\nDjango follows the **Model-View-Controller (MVC)** architecture, which separates the different components of a web application to make development and maintenance easier.\r\n\r\n### The MVC Architecture 🎨\r\n\r\n1. **Model (M)**:  \r\n   - Represents the data and the business logic.  \r\n   - Deals with everything related to the database, such as handling queries and storing data.  \r\n   - Each model is a Python class that represents a table in the database.  \r\n   - Example: A `User` model may represent a table containing user details like name, email, and password. 🗂️\r\n\r\n2. **View (V)**:  \r\n   - Controls what the user sees – it is the user interface.  \r\n   - Fetches data from the model and renders it to the client (browser) through templates.  \r\n   - A view is a Python function that takes a request and returns a response, usually an HTML page. 📄\r\n\r\n3. **Controller (C)**:  \r\n   - Handles the logic that ties the model and the view together.  \r\n   - Processes user input, interacts with the model to update or retrieve data, and then passes that data to the view.  \r\n   - In Django, the controller part is handled by the **Django framework** itself, so it's often referred to as an "MTV" framework (Model-Template-View). 🎮\r\n\r\n### Why is Django Called an MTV Framework? 🤔\r\n\r\nIn Django:\r\n\r\n- **Model (M)** remains the same.\r\n- **Template (T)**: Represents the HTML/CSS files that define the structure of the webpage. 🖌️\r\n- **View (V)**: In Django, a "view" is the Python function that processes user requests and returns a response.\r\n\r\nSo, Django is often referred to as an "MTV" framework, where the **"Template"** replaces the "View" from the traditional MVC architecture.\r\n\r\n---\r\n\r\n### 🚀 Why Choose Django?\r\n\r\n- **Fast Development**: Makes building and deploying web applications quick and easy.\r\n- **Community Support**: A large community of developers who actively contribute to improving the framework.\r\n- **Documentation**: One of the best-documented frameworks with tutorials and guides.\r\n\r\n### Conclusion 🏁\r\n\r\nDjango is a powerful and flexible framework that encourages clean, efficient, and rapid development. Its adherence to the "DRY" principle, built-in security features, and scalable nature make it a great choice for developers of all levels. Let's get started and build something amazing with Django! 💻🔥\r\n\r\n--- \r\n\r\n> "Django makes it easier to build better web apps more quickly and with less code." – Django Documentation 📚	2024-09-01 20:00:14.743791+00	introduction-to-django	1
2	🌟 Introduction to Django	Django is like a magical toolbox 🧰 for web developers who love Python. It's a powerful web framework that lets you build robust and scalable web applications quickly, all while writing clean, readable code. Let's dive deeper into what makes Django so awesome!\r\n\r\n## 🌍 What is Django?\r\n\r\n**Django** is a high-level Python web framework that focuses on rapid development and a clean, pragmatic design. It was created by developers who needed to meet fast-moving newsroom deadlines, so it's designed to help you build applications quickly and efficiently. 🚀\r\n\r\n### 🚀 Key Features of Django\r\n\r\n1. **Batteries Included**: Everything you need is already included! Django comes with built-in components like authentication, admin interfaces, and an ORM (Object-Relational Mapper) to handle database queries. No need to build common features from scratch! 🔋\r\n\r\n2. **Security First**: Django helps protect against common security threats like SQL injection, cross-site scripting (XSS), and cross-site request forgery (CSRF) – so you can focus on building, not worrying. 🛡️\r\n\r\n3. **Scalability and Flexibility**: Whether you're building a small website or a large-scale application, Django can handle it. It’s designed to scale from simple projects to complex applications handling thousands of users. 📊\r\n\r\n4. **DRY Principle**: Stands for “Don’t Repeat Yourself.” Django’s design encourages reuse of code, making development faster and easier. 🏗️\r\n\r\n5. **Vibrant Community**: Django has a large, active community of developers who contribute to improving the framework, building packages, and creating plugins. If you have a problem, there’s always someone who can help! 🤝\r\n\r\n## 🏗️ The Django Architecture: MTV Explained\r\n\r\nDjango follows an architecture pattern called **MTV** – which stands for **Model-Template-View**. It is similar to the MVC (Model-View-Controller) pattern but tailored specifically to web development with Django.\r\n\r\n### 🔍 Understanding MTV\r\n\r\n1. **Model (M)** 🗄️  \r\n   - Think of models as blueprints for your data. They define the structure of your database tables and include all the essential fields and behaviors of the data you store.  \r\n   - Example: A `Product` model might have fields like `name`, `price`, and `description`.  \r\n   - Models are Python classes that Django translates into database queries automatically. 🚀\r\n\r\n2. **Template (T)** 🖌️  \r\n   - Templates are like the paint and canvas of your web page. They define how data is displayed to the user.  \r\n   - They consist of HTML and special template language syntax to dynamically display content.  \r\n   - Example: A template for a blog post page might include placeholders for the title, content, and author name. 📝\r\n\r\n3. **View (V)** 🧑‍💻  \r\n   - Views are the bridge between the **Model** and the **Template**. They process requests, get data from the models, and pass that data to the templates.  \r\n   - A view is a Python function that takes a web request and returns a web response.  \r\n   - Example: A view can fetch all posts from the database and pass them to a template to display as a list on a web page. 📜\r\n\r\n### 💡 So, How is MTV Different from MVC?\r\n\r\n- **Model (M)** is the same in both.\r\n- **Template (T)** in Django replaces the **View** in MVC. It’s responsible for the HTML and presentation layer.\r\n- **View (V)** in Django is more like the **Controller** in MVC. It handles the business logic and ties everything together.\r\n\r\nIn short, Django keeps things simple and intuitive by focusing on **"Templates"** to handle what the user sees and **"Views"** to control the data flow and application logic.\r\n\r\n## 🌟 Why Choose Django?\r\n\r\n1. **Rapid Development**: Helps you develop applications quickly, meeting tight deadlines. ⏰\r\n2. **Clean and Readable Code**: Encourages best practices and makes your code easier to maintain and extend. 🧹\r\n3. **Versatility**: Suitable for both small projects and large-scale applications – think of everything from blogs to social media platforms to e-commerce sites. 🛒\r\n4. **Admin Interface**: Out-of-the-box, customizable admin interface for managing your site’s data without writing extra code. 📊\r\n\r\n## 🎯 Final Thoughts\r\n\r\nDjango is more than just a framework – it's a complete toolkit for web development. With its “batteries-included” philosophy, robust security features, and a massive community of developers, it’s no wonder Django is the framework of choice for companies like Instagram, Pinterest, and even NASA! 🚀\r\n\r\nSo, are you ready to build something amazing with Django? 🌟 Let’s get coding!\r\n\r\n---\r\n\r\n> "With Django, you can do more in less time, and with fewer lines of code!" – Python Enthusiasts 💬	2024-09-01 20:02:48.628352+00	introduction-to-django-2	1
3	📡 Live Chat with Django Channels: A Fun Guide	Welcome to the magical world of live chat with Django Channels! 🚀 Imagine your Django app is a chatty party where everyone is talking in real time. This guide will turn you into the DJ of this party, making sure everyone gets the groove!\r\n\r\n## 🎉 What are Django Channels?\r\n\r\nDjango Channels is like the superpower you never knew you needed! 💪 While Django itself is great for handling web requests, Channels adds the magic of WebSockets, making your app capable of real-time communication. Think of it as Django’s way of saying, "Hey, let’s chat in real-time!"\r\n\r\n## 📦 Installing Django Channels\r\n\r\nFirst things first, let’s get Django Channels into our project. 🛠️ Open your terminal and run:\r\n\r\n```bash\r\npip install channels\r\n```\r\n\r\n## ⚙️ Configuring Django Channels\r\n\r\nNow, let's configure Django Channels in your Django project. Follow these steps to make your project chat-ready:\r\n\r\n1. **Add Channels to Installed Apps**  \r\n   Open your `settings.py` and add `'channels'` to your `INSTALLED_APPS` list:\r\n\r\n```python\r\n   INSTALLED_APPS = [\r\n       # ... your other apps\r\n       'channels',\r\n   ]\r\n```\r\n\r\n2. **Specify the ASGI Application**  \r\n   Still in `settings.py`, set the `ASGI_APPLICATION` to point to your routing configuration:\r\n\r\n```python\r\n   ASGI_APPLICATION = 'your_project_name.asgi.application'\r\n```\r\n\r\n   Replace `your_project_name` with the name of your Django project.\r\n\r\n3. **Create the ASGI Configuration**  \r\n   Create a file named `asgi.py` in your project directory and add the following code:\r\n\r\n```python\r\n   import os\r\n   from django.core.asgi import get_asgi_application\r\n   from channels.routing import ProtocolTypeRouter, URLRouter\r\n   from channels.auth import AuthMiddlewareStack\r\n   from channels.security.websocket import AllowedHostsOriginValidator\r\n   from your_app_name import routing\r\n\r\n   os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'your_project_name.settings')\r\n\r\n   application = ProtocolTypeRouter({\r\n       "http": get_asgi_application(),\r\n       "websocket": AllowedHostsOriginValidator(\r\n           AuthMiddlewareStack(\r\n               URLRouter(\r\n                   routing.websocket_urlpatterns\r\n               )\r\n           )\r\n       ),\r\n   })\r\n```\r\n\r\n   Make sure to replace `your_app_name` and `your_project_name` with the appropriate names.\r\n\r\n## 🗺️ Setting Up Routing\r\n\r\nCreate a file named `routing.py` in your app directory and add:\r\n\r\n```python\r\nfrom django.urls import re_path\r\nfrom . import consumers\r\n\r\nwebsocket_urlpatterns = [\r\n    re_path(r'ws/chat/(?P<room_name>\\w+)/$', consumers.ChatConsumer.as_asgi()),\r\n]\r\n```\r\n\r\n## 🗣️ Creating the Consumer\r\n\r\nThe consumer is like the DJ booth where all the magic happens. Create a file named `consumers.py` in your app directory and add:\r\n\r\n```python\r\nimport json\r\nfrom channels.generic.websocket import AsyncWebsocketConsumer\r\n\r\nclass ChatConsumer(AsyncWebsocketConsumer):\r\n    async def connect(self):\r\n        self.room_name = self.scope['url_route']['kwargs']['room_name']\r\n        self.room_group_name = f'chat_{self.room_name}'\r\n\r\n        await self.channel_layer.group_add(\r\n            self.room_group_name,\r\n            self.channel_name\r\n        )\r\n\r\n        await self.accept()\r\n\r\n    async def disconnect(self, close_code):\r\n        await self.channel_layer.group_discard(\r\n            self.room_group_name,\r\n            self.channel_name\r\n        )\r\n\r\n    async def receive(self, text_data):\r\n        text_data_json = json.loads(text_data)\r\n        message = text_data_json['message']\r\n\r\n        await self.channel_layer.group_send(\r\n            self.room_group_name,\r\n            {\r\n                'type': 'chat_message',\r\n                'message': message\r\n            }\r\n        )\r\n\r\n    async def chat_message(self, event):\r\n        message = event['message']\r\n\r\n        await self.send(text_data=json.dumps({\r\n            'message': message\r\n        }))\r\n```\r\n\r\n## 🏗️ Building the Frontend\r\n\r\nTime to make your chat look snazzy! 🎨 Create a simple HTML file, `chat.html`, for the frontend:\r\n\r\n```html\r\n<!DOCTYPE html>\r\n<html>\r\n<head>\r\n    <title>Chat Room</title>\r\n</head>\r\n<body>\r\n    <h1>Chat Room: {{ room_name }}</h1>\r\n    <div id="chat-log"></div>\r\n    <input id="chat-message-input" type="text" size="100" autofocus />\r\n    <button id="chat-message-submit">Send</button>\r\n\r\n    <script>\r\n        const roomName = "{{ room_name }}";\r\n        const chatSocket = new WebSocket(\r\n            'ws://' + window.location.host + '/ws/chat/' + roomName + '/'\r\n        );\r\n\r\n        chatSocket.onmessage = function(e) {\r\n            const data = JSON.parse(e.data);\r\n            document.querySelector('#chat-log').innerHTML += (data.message + '<br>');\r\n        };\r\n\r\n        chatSocket.onclose = function(e) {\r\n            console.error('Chat socket closed unexpectedly');\r\n        };\r\n\r\n        document.querySelector('#chat-message-input').focus();\r\n        document.querySelector('#chat-message-submit').onclick = function(e) {\r\n            const messageInputDom = document.querySelector('#chat-message-input');\r\n            const message = messageInputDom.value;\r\n            chatSocket.send(JSON.stringify({\r\n                'message': message\r\n            }));\r\n            messageInputDom.value = '';\r\n        };\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n## 🎊 You're Done!\r\n\r\nCongratulations! 🎉 You now have a live chat feature in your Django app. Your users can chat in real-time, and you’re officially a chatroom DJ! 🕺💃\r\n\r\nFeel free to tweak and style everything to your heart’s content. Happy chatting! 🗨️✨\r\n\r\n---	2024-09-02 18:53:22.768065+00	live-chat-with-django-channels-a-fun-guide	1
4	📚 Pandas Guide: From Basics to Advanced	Welcome to the Pandas library guide! Whether you're just starting out or looking to refine your skills, this guide will walk you through Pandas functions with a splash of fun. 😄\r\n\r\n## 🐼 What is Pandas?\r\n\r\nPandas is a powerful library for data manipulation and analysis in Python. It provides data structures like `DataFrame` and `Series` to handle data efficiently. Let's dive into its features!\r\n\r\n---\r\n\r\n## 📦 Getting Started\r\n\r\nFirst things first, let's import Pandas:\r\n\r\n```python\r\nimport pandas as pd\r\n```\r\n\r\n---\r\n\r\n## 🗂️ Creating DataFrames\r\n\r\n### From a Dictionary\r\n\r\n```python\r\ndata = {\r\n    'Name': ['Alice', 'Bob', 'Charlie'],\r\n    'Age': [25, 30, 35],\r\n    'City': ['New York', 'Los Angeles', 'Chicago']\r\n}\r\n\r\ndf = pd.DataFrame(data)\r\nprint(df)\r\n```\r\n\r\n### From a CSV File\r\n\r\n```python\r\ndf = pd.read_csv('file.csv')\r\nprint(df.head())  # Display the first 5 rows\r\n```\r\n\r\n---\r\n\r\n## 🔍 Exploring DataFrames\r\n\r\n### Viewing Data\r\n\r\n- **First and Last Rows**\r\n\r\n```python\r\nprint(df.head())  # First 5 rows\r\nprint(df.tail())  # Last 5 rows\r\n```\r\n\r\n- **DataFrame Shape**\r\n\r\n```python\r\nprint(df.shape)  # (rows, columns)\r\n```\r\n\r\n- **Column Names**\r\n\r\n```python\r\nprint(df.columns)\r\n```\r\n\r\n- **Summary Statistics**\r\n\r\n```python\r\nprint(df.describe())\r\n```\r\n\r\n### Data Selection\r\n\r\n- **Selecting Columns**\r\n\r\n```python\r\nprint(df['Name'])  # Single column\r\nprint(df[['Name', 'Age']])  # Multiple columns\r\n```\r\n\r\n- **Selecting Rows by Index**\r\n\r\n```python\r\nprint(df.iloc[0])  # First row\r\nprint(df.loc[0])   # Row by label (if index is labeled)\r\n```\r\n\r\n- **Conditional Selection**\r\n\r\n```python\r\nprint(df[df['Age'] > 30])\r\n```\r\n\r\n---\r\n\r\n## ✏️ Data Cleaning\r\n\r\n### Handling Missing Values\r\n\r\n- **Drop Missing Values**\r\n\r\n```python\r\ndf_cleaned = df.dropna()\r\n```\r\n\r\n- **Fill Missing Values**\r\n\r\n```python\r\ndf_filled = df.fillna(value={'Age': df['Age'].mean()})\r\n```\r\n\r\n### Removing Duplicates\r\n\r\n```python\r\ndf_unique = df.drop_duplicates()\r\n```\r\n\r\n---\r\n\r\n## 🔄 Data Manipulation\r\n\r\n### Adding and Removing Columns\r\n\r\n- **Add Column**\r\n\r\n```python\r\ndf['Country'] = ['USA', 'USA', 'USA']\r\n```\r\n\r\n- **Remove Column**\r\n\r\n```python\r\ndf = df.drop(columns=['Country'])\r\n```\r\n\r\n### Renaming Columns\r\n\r\n```python\r\ndf.rename(columns={'Name': 'Full Name'}, inplace=True)\r\n```\r\n\r\n### Changing Data Types\r\n\r\n```python\r\ndf['Age'] = df['Age'].astype(float)\r\n```\r\n\r\n---\r\n\r\n## 📊 Data Aggregation\r\n\r\n### Grouping Data\r\n\r\n```python\r\ngrouped = df.groupby('City')\r\nprint(grouped['Age'].mean())  # Mean age per city\r\n```\r\n\r\n### Aggregation Functions\r\n\r\n```python\r\nagg_data = df.agg({\r\n    'Age': ['mean', 'max', 'min'],\r\n    'City': 'count'\r\n})\r\n```\r\n\r\n---\r\n\r\n## 📈 Data Visualization\r\n\r\n### Plotting with Pandas\r\n\r\n```python\r\ndf.plot(kind='bar', x='Name', y='Age')\r\n```\r\n\r\n### Customizing Plots\r\n\r\n```python\r\nimport matplotlib.pyplot as plt\r\n\r\ndf.plot(kind='line', x='Age', y='City')\r\nplt.title('Age vs. City')\r\nplt.xlabel('Age')\r\nplt.ylabel('City')\r\nplt.show()\r\n```\r\n\r\n---\r\n\r\n## 📅 Date and Time Handling\r\n\r\n### Parsing Dates\r\n\r\n```python\r\ndf['Date'] = pd.to_datetime(df['Date'])\r\n```\r\n\r\n### Extracting Date Components\r\n\r\n```python\r\ndf['Year'] = df['Date'].dt.year\r\ndf['Month'] = df['Date'].dt.month\r\n```\r\n\r\n---\r\n\r\n## 🧩 Advanced Topics\r\n\r\n### Merging DataFrames\r\n\r\n- **Merge on Key**\r\n\r\n```python\r\ndf_merged = pd.merge(df1, df2, on='key')\r\n```\r\n\r\n- **Join DataFrames**\r\n\r\n```python\r\ndf_joined = df1.join(df2, lsuffix='_left', rsuffix='_right')\r\n```\r\n\r\n### Pivot Tables\r\n\r\n```python\r\npivot_table = pd.pivot_table(df, values='Age', index='City', aggfunc='mean')\r\n```\r\n\r\n### Reshaping Data\r\n\r\n- **Pivot**\r\n\r\n```python\r\npivot_df = df.pivot(index='Date', columns='City', values='Age')\r\n```\r\n\r\n- **Melt**\r\n\r\n```python\r\nmelted_df = pd.melt(df, id_vars=['Name'], value_vars=['Age', 'City'])\r\n```\r\n\r\n---\r\n\r\n## 🔧 Useful Functions\r\n\r\n### Apply and Lambda\r\n\r\n```python\r\ndf['Age'] = df['Age'].apply(lambda x: x + 1)  # Increase age by 1\r\n```\r\n\r\n### String Methods\r\n\r\n```python\r\ndf['Name'] = df['Name'].str.upper()  # Convert names to uppercase\r\n```\r\n\r\n### DataFrame to Dictionary\r\n\r\n```python\r\ndf_dict = df.to_dict()\r\n```\r\n\r\n---\r\n\r\n## 🎓 Summary\r\n\r\nYou’ve just scratched the surface of what Pandas can do. Here’s a quick recap of the key functions:\r\n\r\n- **Creating DataFrames:** `pd.DataFrame()`, `pd.read_csv()`\r\n- **Exploring DataFrames:** `head()`, `tail()`, `shape`, `describe()`\r\n- **Data Cleaning:** `dropna()`, `fillna()`, `drop_duplicates()`\r\n- **Data Manipulation:** `drop()`, `rename()`, `astype()`\r\n- **Aggregation:** `groupby()`, `agg()`\r\n- **Visualization:** `plot()`\r\n- **Date Handling:** `pd.to_datetime()`, `.dt`\r\n- **Advanced Topics:** `merge()`, `pivot_table()`, `pivot()`, `melt()`\r\n- **Useful Functions:** `apply()`, `str`, `to_dict()`\r\n\r\nHappy Pandas-ing! 🐼✨\r\n\r\n---	2024-09-02 19:23:04.178759+00	pandas-guide-from-basics-to-advanced	1
5	📚 jQuery Fundamentals Cheat Sheet	jQuery is a fast, small, and feature-rich JavaScript library that simplifies **HTML document traversal**, **event handling**, **animating**, and **Ajax interactions** for rapid web development. Let's get started! 🚀\r\n\r\n---\r\n\r\n## 🌟 Getting Started with jQuery\r\n\r\n### 📥 Include jQuery in Your Project\r\n\r\nTo use jQuery, you need to include the library in your HTML file. You can either download it or use a **CDN (Content Delivery Network)**.\r\n\r\n**Include jQuery using a CDN:**\r\n\r\n```html\r\n<!-- Latest minified jQuery version -->\r\n<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n```\r\n\r\nNow you're all set to use jQuery! 🎉\r\n\r\n---\r\n\r\n## ✨ Basic Syntax\r\n\r\nThe jQuery syntax is designed to make things easier. The syntax is:\r\n\r\n```javascript\r\n$(selector).action();\r\n```\r\n\r\n- **`$`**: Refers to jQuery.\r\n- **`selector`**: HTML element(s) you want to select.\r\n- **`action`**: A jQuery action you want to perform on the element(s).\r\n\r\n### Example:\r\n\r\n```html\r\n<!-- HTML Button -->\r\n<button id="myButton">Click me</button>\r\n\r\n<!-- jQuery to hide the button on click -->\r\n<script>\r\n  $(document).ready(function () {\r\n    $('#myButton').click(function () {\r\n      $(this).hide(); // Hides the button on click\r\n    });\r\n  });\r\n</script>\r\n```\r\n\r\n### 🎯 Document Ready\r\n\r\nEnsure that the DOM is fully loaded before running your jQuery code using:\r\n\r\n```javascript\r\n$(document).ready(function () {\r\n  // Your jQuery code here\r\n});\r\n```\r\n\r\nOr a shorter version:\r\n\r\n```javascript\r\n$(function () {\r\n  // Your jQuery code here\r\n});\r\n```\r\n\r\n---\r\n\r\n## 🔍 jQuery Selectors\r\n\r\njQuery selectors allow you to select and manipulate HTML elements. They are similar to CSS selectors.\r\n\r\n### 🔖 Common Selectors:\r\n\r\n| Selector      | Description                                     | Example                      |\r\n|---------------|-------------------------------------------------|------------------------------|\r\n| `*`           | Selects all elements                            | `$(" * ")`                   |\r\n| `#id`         | Selects element with the specified ID           | `$("#myId")`                 |\r\n| `.class`      | Selects all elements with the specified class    | `$(".myClass")`              |\r\n| `element`     | Selects all elements with the given tag name     | `$("p")`                     |\r\n| `:first`      | Selects the first matched element               | `$("p:first")`               |\r\n| `[attribute]` | Selects elements with a specific attribute      | `$("input[name='name']")`    |\r\n\r\n### Example:\r\n\r\n```html\r\n<!-- HTML Paragraphs -->\r\n<p>First paragraph</p>\r\n<p class="highlight">Second paragraph</p>\r\n<p id="special">Third paragraph</p>\r\n\r\n<!-- jQuery to apply styles -->\r\n<script>\r\n  $(document).ready(function () {\r\n    $("p").css("color", "blue"); // All paragraphs turn blue\r\n    $(".highlight").css("font-weight", "bold"); // Bold the class 'highlight'\r\n    $("#special").css("font-size", "20px"); // Increase font size of ID 'special'\r\n  });\r\n</script>\r\n```\r\n\r\n---\r\n\r\n## 🎬 Event Handling\r\n\r\njQuery makes handling events simple and intuitive. Here are some common event methods:\r\n\r\n- **`click()`**: Triggered when an element is clicked.\r\n- **`hover()`**: A combination of `mouseenter` and `mouseleave`.\r\n- **`focus()`**: Triggered when an element gains focus.\r\n- **`blur()`**: Triggered when an element loses focus.\r\n\r\n### Example:\r\n\r\n```html\r\n<!-- HTML Input -->\r\n<input type="text" id="inputField" placeholder="Type here">\r\n\r\n<!-- jQuery for Event Handling -->\r\n<script>\r\n  $(document).ready(function () {\r\n    $("#inputField").focus(function () {\r\n      $(this).css("background-color", "#e0f7fa");\r\n    });\r\n    $("#inputField").blur(function () {\r\n      $(this).css("background-color", "#ffffff");\r\n    });\r\n  });\r\n</script>\r\n```\r\n\r\n---\r\n\r\n## 🛠️ DOM Manipulation\r\n\r\njQuery makes it easy to manipulate the DOM.\r\n\r\n### ✏️ Modifying Content:\r\n\r\n- **`text()`**: Sets or returns the text content.\r\n- **`html()`**: Sets or returns the HTML content.\r\n- **`val()`**: Sets or returns the value of form fields.\r\n\r\n### Example:\r\n\r\n```html\r\n<!-- HTML Content -->\r\n<p id="demo">Hello World!</p>\r\n\r\n<!-- jQuery to Change Content -->\r\n<script>\r\n  $(document).ready(function () {\r\n    $("#demo").text("Hello jQuery!"); // Changes text content\r\n    $("#demo").html("<b>Hello jQuery!</b>"); // Changes HTML content\r\n  });\r\n</script>\r\n```\r\n\r\n### 🌲 Adding and Removing Elements:\r\n\r\n- **`append()`**: Adds content to the end.\r\n- **`prepend()`**: Adds content to the beginning.\r\n- **`remove()`**: Removes selected elements.\r\n- **`empty()`**: Removes child elements of the selected element.\r\n\r\n### Example:\r\n\r\n```html\r\n<!-- HTML List -->\r\n<ul id="fruits">\r\n  <li>Apple</li>\r\n  <li>Banana</li>\r\n</ul>\r\n\r\n<!-- jQuery to Manipulate List -->\r\n<script>\r\n  $(document).ready(function () {\r\n    $("#fruits").append("<li>Cherry</li>"); // Adds 'Cherry' to the end\r\n    $("#fruits").prepend("<li>Mango</li>"); // Adds 'Mango' to the beginning\r\n    $("#fruits li:first").remove(); // Removes the first item\r\n  });\r\n</script>\r\n```\r\n\r\n---\r\n\r\n## 🎨 Animations and Effects\r\n\r\njQuery comes with built-in animation methods.\r\n\r\n### ✨ Common Effects:\r\n\r\n- **`show(speed, callback)`**: Shows the selected elements.\r\n- **`hide(speed, callback)`**: Hides the selected elements.\r\n- **`toggle(speed, callback)`**: Toggles between showing and hiding.\r\n- **`fadeIn(speed, callback)`**: Fades in the selected elements.\r\n- **`fadeOut(speed, callback)`**: Fades out the selected elements.\r\n- **`slideDown(speed, callback)`**: Slides down the selected elements.\r\n- **`slideUp(speed, callback)`**: Slides up the selected elements.\r\n\r\n### Example:\r\n\r\n```html\r\n<!-- HTML Button -->\r\n<button id="toggleButton">Toggle</button>\r\n<p id="toggleText">This is a paragraph.</p>\r\n\r\n<!-- jQuery for Animation -->\r\n<script>\r\n  $(document).ready(function () {\r\n    $("#toggleButton").click(function () {\r\n      $("#toggleText").toggle(1000); // Toggles the visibility of the paragraph\r\n    });\r\n  });\r\n</script>\r\n```\r\n\r\n---\r\n\r\n## 🚀 Advanced jQuery\r\n\r\n### 🌐 AJAX with jQuery\r\n\r\nAJAX allows for asynchronous web requests, and jQuery makes it simple!\r\n\r\n#### `$.ajax()` Method:\r\n\r\n```javascript\r\n$.ajax({\r\n  url: "https://api.example.com/data",\r\n  method: "GET",\r\n  success: function (data) {\r\n    console.log(data); // Process data on success\r\n  },\r\n  error: function (error) {\r\n    console.error("Error fetching data:", error);\r\n  }\r\n});\r\n```\r\n\r\n#### Shorthand Methods:\r\n\r\n- **`$.get(url, success)`**: GET request.\r\n- **`$.post(url, data, success)`**: POST request.\r\n\r\n### Example:\r\n\r\n```javascript\r\n$.get("https://api.example.com/data", function (data) {\r\n  console.log(data);\r\n});\r\n```\r\n\r\n### 🔁 Chaining\r\n\r\njQuery allows method chaining for cleaner code:\r\n\r\n```javascript\r\n$("#myElement").css("color", "blue").slideUp(2000).slideDown(2000);\r\n```\r\n\r\n### 🧩 Plugins\r\n\r\nYou can extend jQuery using plugins for additional functionality. To use a plugin, include it after the jQuery script.\r\n\r\n---\r\n\r\n## 🔍 Debugging Tips\r\n\r\n- Use **`console.log()`** to print messages and debug.\r\n- Use browser developer tools to inspect the DOM and understand your jQuery code.\r\n\r\n### 🛠️ Performance Tips\r\n\r\n- Minimize the number of selectors.\r\n- Use **IDs** over **classes** for faster selections.\r\n- Cache jQuery selectors to avoid redundancy.\r\n\r\n### ⚡ Conclusion\r\n\r\njQuery is a powerful tool for web development. Its easy-to-understand syntax, rich features, and ability to extend functionality using plugins make it a popular choice among developers. Keep experimenting and building! 🌈	2024-09-10 20:57:12.802498+00	jquery-fundamentals-cheat-sheet	2
6	Intro to Jquery and Jquery Selectors	### 1. **Introduction to jQuery**\r\n\r\n#### What is jQuery?\r\njQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler with an easy-to-use API that works across a multitude of browsers. It was designed to simplify client-side scripting and provide a unified approach to interacting with the DOM (Document Object Model), ensuring that developers don’t have to write browser-specific code.\r\n\r\n**Key Features of jQuery**:\r\n- **Cross-browser compatibility**: jQuery abstracts away browser-specific differences.\r\n- **DOM manipulation**: Simplifies tasks like modifying HTML content, styling, and element structures.\r\n- **Event handling**: Simplifies the process of handling user events like clicks, mouseovers, and form submissions.\r\n- **AJAX support**: Provides functions for making asynchronous requests to the server.\r\n- **Animation**: Allows the creation of smooth, dynamic animations.\r\n\r\n#### Importance of jQuery in Web Development\r\njQuery plays an essential role in web development because it:\r\n- **Reduces development time**: By providing simple methods to interact with the DOM, handle events, and animate elements, jQuery reduces the amount of code developers need to write.\r\n- **Cross-browser compatibility**: With jQuery, developers don't need to worry about JavaScript behaving differently across different browsers.\r\n- **Simplifies AJAX**: jQuery makes it straightforward to load external data dynamically without reloading the page.\r\n- **Rich Ecosystem**: There is a vast library of plugins, tools, and extensions built on jQuery, making it easier to add advanced features (like carousels, modals, etc.) to websites without reinventing the wheel.\r\n  \r\n**Example**:  \r\nIn native JavaScript, changing the text of an element might look like this:\r\n```javascript\r\ndocument.getElementById('myElement').innerHTML = "Hello, World!";\r\n```\r\n\r\nWith jQuery, you can achieve the same with:\r\n```javascript\r\n$('#myElement').html("Hello, World!");\r\n```\r\n\r\n#### Including jQuery in a Web Page\r\nTo use jQuery, you need to include it in your webpage, either by downloading the library and hosting it yourself or by using a CDN (Content Delivery Network).\r\n\r\n**Including via CDN**:\r\nYou can add jQuery to your HTML by adding this line inside the `<head>` or just before the closing `</body>` tag:\r\n```html\r\n<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n```\r\n\r\nAlternatively, you can download jQuery and include it like this:\r\n```html\r\n<script src="path/to/jquery.min.js"></script>\r\n```\r\n\r\nOnce jQuery is included, you can start using its functionality in your script.\r\n\r\n---\r\n\r\n### Mini Project: **Simple Website with jQuery Integration**\r\n**Goal**: Build a static webpage and use jQuery to manipulate the DOM.\r\n\r\n1. Create a simple HTML page:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Simple jQuery Webpage</title>\r\n</head>\r\n<body>\r\n    <h1 id="title">Welcome to My jQuery Webpage</h1>\r\n    <button id="changeText">Change Text</button>\r\n    <button id="changeColor">Change Color</button>\r\n    <button id="toggleElement">Hide/Show Title</button>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            // Change text on button click\r\n            $('#changeText').click(function() {\r\n                $('#title').text("Text Changed using jQuery!");\r\n            });\r\n\r\n            // Change color on button click\r\n            $('#changeColor').click(function() {\r\n                $('#title').css('color', 'blue');\r\n            });\r\n\r\n            // Toggle visibility on button click\r\n            $('#toggleElement').click(function() {\r\n                $('#title').toggle();\r\n            });\r\n        });\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n**Explanation**:\r\n- **HTML Structure**: You have a title and three buttons. Each button performs a different jQuery action.\r\n- **Change Text**: Clicking the “Change Text” button changes the text of the title.\r\n- **Change Color**: Clicking the “Change Color” button changes the color of the title to blue.\r\n- **Toggle Visibility**: The “Hide/Show Title” button hides or shows the title using the `.toggle()` method.\r\n\r\n---\r\n\r\n### 2. **jQuery Selectors**\r\n\r\nSelectors in jQuery allow you to find and manipulate HTML elements based on their attributes, tags, IDs, classes, and more. jQuery selectors are designed to be concise and powerful.\r\n\r\n#### Basic Selectors\r\n- **ID Selector (`#id`)**: Selects an element by its ID.  \r\n  Example:\r\n  ```javascript\r\n  $('#myElement').text("This is selected by ID");\r\n  ```\r\n\r\n- **Class Selector (`.class`)**: Selects all elements with the specified class.  \r\n  Example:\r\n  ```javascript\r\n  $('.myClass').css('background-color', 'yellow');\r\n  ```\r\n\r\n- **Tag Selector (`tag`)**: Selects all elements of a given tag type (e.g., `p`, `div`, etc.).  \r\n  Example:\r\n  ```javascript\r\n  $('p').css('font-size', '18px');\r\n  ```\r\n\r\n#### Attribute Selectors\r\njQuery allows you to select elements based on their attributes. This is useful when targeting elements with specific properties.\r\n\r\n- **Attribute Exists Selector (`[attribute]`)**: Selects all elements with a specific attribute.  \r\n  Example:\r\n  ```javascript\r\n  $('img[alt]').css('border', '1px solid red');\r\n  ```\r\n\r\n- **Attribute Value Selector (`[attribute=value]`)**: Selects elements that have an attribute with a specific value.  \r\n  Example:\r\n  ```javascript\r\n  $('input[type="text"]').val('Default Text');\r\n  ```\r\n\r\n#### Child and Sibling Selectors\r\n- **Child Selector (`parent > child`)**: Selects direct child elements of a specific parent.  \r\n  Example:\r\n  ```javascript\r\n  $('ul > li').css('color', 'green');\r\n  ```\r\n\r\n- **Sibling Selector (`prev + next`)**: Selects the next sibling of an element.  \r\n  Example:\r\n  ```javascript\r\n  $('h2 + p').css('font-weight', 'bold');\r\n  ```\r\n\r\n#### Mini Project: **Image Gallery**\r\n**Goal**: Create an image gallery where clicking on thumbnails changes the main image using jQuery selectors.\r\n\r\n1. HTML structure for the image gallery:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>jQuery Image Gallery</title>\r\n    <style>\r\n        .thumbnails img {\r\n            width: 100px;\r\n            cursor: pointer;\r\n        }\r\n        #mainImage {\r\n            width: 400px;\r\n            display: block;\r\n            margin-bottom: 10px;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n    <h1>jQuery Image Gallery</h1>\r\n    <img id="mainImage" src="image1.jpg" alt="Main Image">\r\n    \r\n    <div class="thumbnails">\r\n        <img src="image1.jpg" alt="Thumbnail 1">\r\n        <img src="image2.jpg" alt="Thumbnail 2">\r\n        <img src="image3.jpg" alt="Thumbnail 3">\r\n    </div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            // Change main image on thumbnail click\r\n            $('.thumbnails img').click(function() {\r\n                var newSrc = $(this).attr('src');\r\n                $('#mainImage').attr('src', newSrc);\r\n            });\r\n        });\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n**Explanation**:\r\n- **HTML Structure**: A main image is displayed at the top, and below it, there are several thumbnail images.\r\n- **jQuery Selector**: When any thumbnail is clicked, the source (`src`) of the clicked image is retrieved and used to update the `src` attribute of the main image.	2024-09-17 17:50:58.145017+00	intro-to-jquery-and-jquery-selectors	2
7	jQuery Events	### 3. **jQuery Events**\r\n\r\nIn jQuery, events refer to the actions or occurrences that happen in the browser (like mouse clicks, key presses, and page loads) to which you can respond using JavaScript. jQuery simplifies handling events by providing a uniform interface to interact with them across different browsers. \r\n\r\n#### Mouse Events\r\nMouse events are triggered when the user interacts with elements using the mouse (or other pointing devices). Common mouse events include:\r\n\r\n1. **click**: Fired when an element is clicked.\r\n    ```javascript\r\n    $('#button').click(function() {\r\n        alert('Button clicked!');\r\n    });\r\n    ```\r\n\r\n2. **dblclick**: Fired when an element is double-clicked.\r\n    ```javascript\r\n    $('#element').dblclick(function() {\r\n        $(this).css('color', 'red');\r\n    });\r\n    ```\r\n\r\n3. **hover**: Fired when the mouse pointer enters and leaves an element. Hover combines `mouseenter` and `mouseleave` events.\r\n    ```javascript\r\n    $('#element').hover(\r\n        function() {\r\n            $(this).css('background-color', 'yellow'); // mouse enter\r\n        },\r\n        function() {\r\n            $(this).css('background-color', ''); // mouse leave\r\n        }\r\n    );\r\n    ```\r\n\r\n4. **mousedown**: Fired when a mouse button is pressed.\r\n    ```javascript\r\n    $('#element').mousedown(function() {\r\n        $(this).css('border', '2px solid blue');\r\n    });\r\n    ```\r\n\r\n5. **mouseup**: Fired when the mouse button is released.\r\n    ```javascript\r\n    $('#element').mouseup(function() {\r\n        $(this).css('border', '');\r\n    });\r\n    ```\r\n\r\n#### Keyboard Events\r\nThese events capture user interaction with the keyboard. Common keyboard events include:\r\n\r\n1. **keypress**: Fired when a key is pressed down and released.\r\n    ```javascript\r\n    $('#input').keypress(function(event) {\r\n        alert('Key pressed: ' + event.key);\r\n    });\r\n    ```\r\n\r\n2. **keydown**: Fired when a key is pressed down.\r\n    ```javascript\r\n    $('#input').keydown(function(event) {\r\n        console.log('Key pressed: ' + event.key);\r\n    });\r\n    ```\r\n\r\n3. **keyup**: Fired when a key is released.\r\n    ```javascript\r\n    $('#input').keyup(function(event) {\r\n        console.log('Key released: ' + event.key);\r\n    });\r\n    ```\r\n\r\nThese events are commonly used in scenarios like real-time form validation, search as you type, and other dynamic interactions.\r\n\r\n#### Form Events\r\nForm events are triggered when users interact with HTML forms. These include events related to input fields and submission:\r\n\r\n1. **submit**: Fired when a form is submitted.\r\n    ```javascript\r\n    $('form').submit(function(event) {\r\n        event.preventDefault(); // Prevent form submission\r\n        alert('Form submitted!');\r\n    });\r\n    ```\r\n\r\n2. **focus**: Fired when an input field receives focus.\r\n    ```javascript\r\n    $('input').focus(function() {\r\n        $(this).css('background-color', '#f0f0f0');\r\n    });\r\n    ```\r\n\r\n3. **blur**: Fired when an input field loses focus.\r\n    ```javascript\r\n    $('input').blur(function() {\r\n        $(this).css('background-color', '');\r\n    });\r\n    ```\r\n\r\nThese form events are typically used to trigger real-time form validation, display hints, or adjust styling based on user input.\r\n\r\n#### Document Events\r\nDocument events refer to interactions with the entire document (or window) rather than individual elements.\r\n\r\n1. **ready**: Fired when the DOM (Document Object Model) is fully loaded. This is one of the most common events in jQuery and is used to ensure that jQuery code runs only after the page's content has been fully loaded.\r\n    ```javascript\r\n    $(document).ready(function() {\r\n        console.log("DOM is ready!");\r\n    });\r\n    ```\r\n\r\n2. **load**: Fired when all elements on the page, including images, are fully loaded. \r\n    ```javascript\r\n    $(window).on('load', function() {\r\n        alert("All resources loaded, including images!");\r\n    });\r\n    ```\r\n\r\n---\r\n\r\n### Mini Project: **Interactive Form Validation**\r\n\r\n**Goal**: Build a form that validates input fields in real-time using jQuery event handling. We’ll validate email, password, and a confirm password field, ensuring that the data meets specific criteria before allowing submission.\r\n\r\n#### HTML Form\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Interactive Form Validation</title>\r\n    <style>\r\n        .error {\r\n            color: red;\r\n        }\r\n        .valid {\r\n            color: green;\r\n        }\r\n        input {\r\n            display: block;\r\n            margin-bottom: 10px;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n    <h1>Registration Form</h1>\r\n    <form id="registrationForm">\r\n        <label for="email">Email:</label>\r\n        <input type="email" id="email" name="email">\r\n        <span id="emailError" class="error"></span>\r\n\r\n        <label for="password">Password:</label>\r\n        <input type="password" id="password" name="password">\r\n        <span id="passwordError" class="error"></span>\r\n\r\n        <label for="confirmPassword">Confirm Password:</label>\r\n        <input type="password" id="confirmPassword" name="confirmPassword">\r\n        <span id="confirmPasswordError" class="error"></span>\r\n\r\n        <button type="submit">Register</button>\r\n    </form>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            // Email validation\r\n            $('#email').keyup(function() {\r\n                var email = $(this).val();\r\n                var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$/;\r\n                if (emailPattern.test(email)) {\r\n                    $('#emailError').text('Valid email').removeClass('error').addClass('valid');\r\n                } else {\r\n                    $('#emailError').text('Invalid email').removeClass('valid').addClass('error');\r\n                }\r\n            });\r\n\r\n            // Password validation\r\n            $('#password').keyup(function() {\r\n                var password = $(this).val();\r\n                if (password.length < 6) {\r\n                    $('#passwordError').text('Password must be at least 6 characters long').addClass('error');\r\n                } else {\r\n                    $('#passwordError').text('Valid password').removeClass('error').addClass('valid');\r\n                }\r\n            });\r\n\r\n            // Confirm Password validation\r\n            $('#confirmPassword').keyup(function() {\r\n                var password = $('#password').val();\r\n                var confirmPassword = $(this).val();\r\n                if (password !== confirmPassword) {\r\n                    $('#confirmPasswordError').text('Passwords do not match').addClass('error');\r\n                } else {\r\n                    $('#confirmPasswordError').text('Passwords match').removeClass('error').addClass('valid');\r\n                }\r\n            });\r\n\r\n            // Prevent form submission if validation fails\r\n            $('#registrationForm').submit(function(event) {\r\n                var emailError = $('#emailError').hasClass('error');\r\n                var passwordError = $('#passwordError').hasClass('error');\r\n                var confirmPasswordError = $('#confirmPasswordError').hasClass('error');\r\n                \r\n                if (emailError || passwordError || confirmPasswordError) {\r\n                    event.preventDefault();\r\n                    alert('Please fix the errors before submitting the form.');\r\n                } else {\r\n                    alert('Form submitted successfully!');\r\n                }\r\n            });\r\n        });\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n- **Email Validation**: On every key press in the email field (`keyup` event), we check if the entered email matches a valid email pattern using a regular expression.\r\n- **Password Validation**: The password must be at least 6 characters long. We update the error message in real-time as the user types.\r\n- **Confirm Password Validation**: This checks whether the confirm password field matches the password field.\r\n- **Form Submission**: We use the `submit` event to check for any validation errors before allowing the form to be submitted. If errors are present, we prevent the form from being submitted and show an alert.\r\n\r\n**Key jQuery Features Used**:\r\n- **Event Handling**: `keyup` and `submit` to respond to user actions.\r\n- **Regular Expressions**: To validate the email format.\r\n- **Class Manipulation**: Dynamically adding or removing classes (`error` or `valid`) to show validation results.\r\n- **Real-time Feedback**: Updates the validation message as the user types.\r\n\r\nThis project illustrates how jQuery event handling can be used to create dynamic, real-time interactions in forms, improving the user experience.	2024-09-17 17:51:44.661012+00	jquery-events	2
8	jQuery Effects	### 4. **jQuery Effects**\r\n\r\njQuery provides several built-in effects that allow you to animate elements and create smooth transitions on your webpage. These effects can enhance user interaction and improve the visual appeal of your website without needing complex CSS or JavaScript.\r\n\r\n#### Show and Hide\r\n\r\n- **show()**: Displays the selected element if it is hidden.\r\n    ```javascript\r\n    $('#element').show();\r\n    ```\r\n    This method can be used to reveal an element that is hidden, either through CSS or JavaScript.\r\n\r\n- **hide()**: Hides the selected element.\r\n    ```javascript\r\n    $('#element').hide();\r\n    ```\r\n    When you want to make an element disappear from the page, `hide()` will do the job by setting the `display` property to `none`.\r\n\r\n##### Example:\r\n```html\r\n<button id="showBtn">Show</button>\r\n<button id="hideBtn">Hide</button>\r\n<div id="box" style="width:100px; height:100px; background-color:blue; display:none;"></div>\r\n\r\n<script>\r\n    $('#showBtn').click(function() {\r\n        $('#box').show();\r\n    });\r\n\r\n    $('#hideBtn').click(function() {\r\n        $('#box').hide();\r\n    });\r\n</script>\r\n```\r\nIn this example, clicking "Show" will display the blue box, and clicking "Hide" will make it disappear.\r\n\r\n#### Toggle\r\n\r\n- **toggle()**: Toggles between the `show()` and `hide()` states.\r\n    ```javascript\r\n    $('#element').toggle();\r\n    ```\r\n    If the element is visible, `toggle()` will hide it, and if it is hidden, it will show it.\r\n\r\n##### Example:\r\n```html\r\n<button id="toggleBtn">Toggle Visibility</button>\r\n<div id="box" style="width:100px; height:100px; background-color:red;"></div>\r\n\r\n<script>\r\n    $('#toggleBtn').click(function() {\r\n        $('#box').toggle();\r\n    });\r\n</script>\r\n```\r\nClicking the "Toggle Visibility" button will either show or hide the box, depending on its current state.\r\n\r\n#### Fade Effects\r\n\r\n- **fadeIn()**: Gradually changes the opacity of an element to make it appear.\r\n    ```javascript\r\n    $('#element').fadeIn();\r\n    ```\r\n\r\n- **fadeOut()**: Gradually changes the opacity of an element to make it disappear.\r\n    ```javascript\r\n    $('#element').fadeOut();\r\n    ```\r\n\r\n- **fadeToggle()**: Toggles the `fadeIn()` and `fadeOut()` effects.\r\n    ```javascript\r\n    $('#element').fadeToggle();\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<button id="fadeBtn">Fade In/Out</button>\r\n<div id="fadeBox" style="width:100px; height:100px; background-color:green;"></div>\r\n\r\n<script>\r\n    $('#fadeBtn').click(function() {\r\n        $('#fadeBox').fadeToggle();\r\n    });\r\n</script>\r\n```\r\nThis will apply a smooth fading effect to the green box whenever the button is clicked.\r\n\r\n#### Slide Effects\r\n\r\n- **slideUp()**: Hides an element with a sliding motion by reducing its height to 0.\r\n    ```javascript\r\n    $('#element').slideUp();\r\n    ```\r\n\r\n- **slideDown()**: Displays a hidden element with a sliding motion.\r\n    ```javascript\r\n    $('#element').slideDown();\r\n    ```\r\n\r\n- **slideToggle()**: Toggles between `slideUp()` and `slideDown()`.\r\n    ```javascript\r\n    $('#element').slideToggle();\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<button id="slideBtn">Slide Up/Down</button>\r\n<div id="slideBox" style="width:100px; height:100px; background-color:yellow;"></div>\r\n\r\n<script>\r\n    $('#slideBtn').click(function() {\r\n        $('#slideBox').slideToggle();\r\n    });\r\n</script>\r\n```\r\nClicking the button will slide the yellow box up and down.\r\n\r\n#### Custom Animations\r\n\r\njQuery allows you to define your own animations using the **animate()** method. You can control properties such as height, width, opacity, and many more, giving you full control over the animation process.\r\n\r\n- **animate()**: Animates custom CSS properties.\r\n    ```javascript\r\n    $('#element').animate({\r\n        width: '300px',\r\n        opacity: 0.5\r\n    }, 1000); // Animates in 1 second\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<button id="animateBtn">Animate</button>\r\n<div id="animateBox" style="width:100px; height:100px; background-color:purple;"></div>\r\n\r\n<script>\r\n    $('#animateBtn').click(function() {\r\n        $('#animateBox').animate({\r\n            width: '300px',\r\n            height: '300px',\r\n            opacity: 0.5\r\n        }, 1000); // Animates in 1 second\r\n    });\r\n</script>\r\n```\r\nWhen the button is clicked, the purple box will smoothly expand in size and reduce its opacity.\r\n\r\n---\r\n\r\n### Mini Project: **Collapsible FAQ Section**\r\n\r\n**Goal**: Create a FAQ section where clicking on questions reveals or hides the answers using jQuery slide and fade effects.\r\n\r\n#### HTML Structure for FAQ Section:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Collapsible FAQ Section</title>\r\n    <style>\r\n        .faq-section {\r\n            width: 400px;\r\n            margin: 20px auto;\r\n        }\r\n        .faq-question {\r\n            cursor: pointer;\r\n            padding: 10px;\r\n            background-color: #f7f7f7;\r\n            margin-bottom: 5px;\r\n            border: 1px solid #ccc;\r\n        }\r\n        .faq-answer {\r\n            display: none;\r\n            padding: 10px;\r\n            background-color: #f0f0f0;\r\n            border: 1px solid #ddd;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n    <div class="faq-section">\r\n        <div class="faq-item">\r\n            <div class="faq-question">What is jQuery?</div>\r\n            <div class="faq-answer">jQuery is a lightweight JavaScript library that simplifies HTML DOM manipulation, event handling, and animations.</div>\r\n        </div>\r\n        <div class="faq-item">\r\n            <div class="faq-question">How does jQuery simplify JavaScript?</div>\r\n            <div class="faq-answer">jQuery provides a simple API that works across browsers and makes it easy to write powerful JavaScript with less code.</div>\r\n        </div>\r\n        <div class="faq-item">\r\n            <div class="faq-question">What is a jQuery plugin?</div>\r\n            <div class="faq-answer">A jQuery plugin is a method that extends jQuery's functionality, allowing you to reuse code across projects.</div>\r\n        </div>\r\n    </div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            $('.faq-question').click(function() {\r\n                // Toggle the corresponding answer using slide and fade effects\r\n                $(this).next('.faq-answer').slideToggle(300).fadeToggle(300);\r\n            });\r\n        });\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n- **HTML Structure**: Each FAQ item consists of a question and an answer. The questions are clickable, and the answers are hidden by default.\r\n- **jQuery Effects**: When a question is clicked, the corresponding answer is toggled using a combination of `slideToggle()` and `fadeToggle()`. This creates a smooth, combined sliding and fading effect.\r\n- **.faq-item**: Each question-answer pair is wrapped in a `.faq-item` div for better structure and styling.\r\n- **Events**: The `.faq-question` has a `click` event attached to it. When a question is clicked, the `.faq-answer` associated with it is shown or hidden.\r\n\r\nThis collapsible FAQ section provides a clean and user-friendly way to present frequently asked questions, allowing users to reveal answers with a smooth animation.	2024-09-17 17:52:32.988539+00	jquery-effects	2
9	jQuery DOM Manipulation	### 5. **jQuery DOM Manipulation**\r\n\r\nDOM (Document Object Model) manipulation is one of jQuery's most powerful features, allowing you to dynamically update the structure, content, and styling of web pages. With jQuery, you can effortlessly interact with and modify the HTML content and elements of your page in real time.\r\n\r\n#### Text and HTML Manipulation\r\n\r\n- **text()**: Used to get or set the text content of an element. When called without arguments, it retrieves the text content of the selected element. When provided with an argument, it sets the text of the element.\r\n    ```javascript\r\n    // Get text\r\n    var content = $('#element').text();\r\n    \r\n    // Set text\r\n    $('#element').text('This is new text content');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<div id="message">Hello, World!</div>\r\n<button id="changeTextBtn">Change Text</button>\r\n\r\n<script>\r\n    $('#changeTextBtn').click(function() {\r\n        $('#message').text('Text has been changed!');\r\n    });\r\n</script>\r\n```\r\nIn this example, when the button is clicked, the text inside the `#message` div is changed using `text()`.\r\n\r\n- **html()**: Similar to `text()`, but it can get or set the **HTML** content of an element. It interprets the string as HTML, meaning you can add HTML tags inside the content.\r\n    ```javascript\r\n    // Get HTML content\r\n    var htmlContent = $('#element').html();\r\n    \r\n    // Set HTML content\r\n    $('#element').html('<strong>Bold text</strong>');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<div id="content">This is <em>italic</em> text.</div>\r\n<button id="changeHtmlBtn">Change HTML</button>\r\n\r\n<script>\r\n    $('#changeHtmlBtn').click(function() {\r\n        $('#content').html('<strong>This is bold text now!</strong>');\r\n    });\r\n</script>\r\n```\r\nHere, the HTML content is updated to include a `<strong>` tag when the button is clicked.\r\n\r\n#### Append, Prepend, and Remove Elements\r\n\r\n- **append()**: Inserts content to the end of the selected elements.\r\n    ```javascript\r\n    $('#list').append('<li>New Item</li>');\r\n    ```\r\n\r\n- **prepend()**: Inserts content at the beginning of the selected elements.\r\n    ```javascript\r\n    $('#list').prepend('<li>First Item</li>');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<ul id="list">\r\n    <li>Item 1</li>\r\n    <li>Item 2</li>\r\n</ul>\r\n<button id="addItemBtn">Add Item</button>\r\n\r\n<script>\r\n    $('#addItemBtn').click(function() {\r\n        $('#list').append('<li>New Item</li>');\r\n    });\r\n</script>\r\n```\r\nIn this case, every time the button is clicked, a new item is appended to the end of the list.\r\n\r\n- **remove()**: Removes the selected element(s) from the DOM.\r\n    ```javascript\r\n    $('#element').remove();\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<ul id="list">\r\n    <li>Item 1 <button class="removeItem">Remove</button></li>\r\n    <li>Item 2 <button class="removeItem">Remove</button></li>\r\n</ul>\r\n\r\n<script>\r\n    $('.removeItem').click(function() {\r\n        $(this).parent().remove();\r\n    });\r\n</script>\r\n```\r\nIn this example, clicking the "Remove" button will remove the corresponding list item from the DOM.\r\n\r\n#### Class and Attribute Manipulation\r\n\r\n- **addClass()**: Adds one or more classes to the selected elements.\r\n    ```javascript\r\n    $('#element').addClass('highlight');\r\n    ```\r\n\r\n- **removeClass()**: Removes one or more classes from the selected elements.\r\n    ```javascript\r\n    $('#element').removeClass('highlight');\r\n    ```\r\n\r\n- **toggleClass()**: Toggles between adding and removing a class from the selected elements.\r\n    ```javascript\r\n    $('#element').toggleClass('highlight');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<div id="box" class="square"></div>\r\n<button id="toggleClassBtn">Toggle Highlight</button>\r\n\r\n<script>\r\n    $('#toggleClassBtn').click(function() {\r\n        $('#box').toggleClass('highlight');\r\n    });\r\n</script>\r\n```\r\nIn this example, clicking the button will toggle the class `highlight` on the `#box` element, dynamically changing its styling.\r\n\r\n- **attr()**: Gets or sets the attribute value of an element.\r\n    ```javascript\r\n    // Get attribute\r\n    var value = $('#element').attr('id');\r\n    \r\n    // Set attribute\r\n    $('#element').attr('title', 'This is a title');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<img id="myImage" src="image1.jpg" alt="First Image">\r\n<button id="changeImageBtn">Change Image</button>\r\n\r\n<script>\r\n    $('#changeImageBtn').click(function() {\r\n        $('#myImage').attr('src', 'image2.jpg');\r\n    });\r\n</script>\r\n```\r\nHere, when the button is clicked, the `src` attribute of the image is changed, replacing it with a different image.\r\n\r\n---\r\n\r\n### Mini Project: **To-Do List Application**\r\n\r\n**Goal**: Build a simple to-do list application where users can add, edit, and remove tasks using jQuery DOM manipulation methods.\r\n\r\n#### HTML Structure:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>To-Do List App</title>\r\n    <style>\r\n        body {\r\n            font-family: Arial, sans-serif;\r\n        }\r\n        #todo-list {\r\n            list-style: none;\r\n            padding: 0;\r\n        }\r\n        #todo-list li {\r\n            padding: 10px;\r\n            background-color: #f7f7f7;\r\n            margin-bottom: 5px;\r\n            display: flex;\r\n            justify-content: space-between;\r\n        }\r\n        .edit-task, .delete-task {\r\n            margin-left: 10px;\r\n            cursor: pointer;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n    <h1>To-Do List</h1>\r\n    <input type="text" id="taskInput" placeholder="Enter a new task">\r\n    <button id="addTaskBtn">Add Task</button>\r\n    <ul id="todo-list"></ul>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            // Add Task\r\n            $('#addTaskBtn').click(function() {\r\n                var taskText = $('#taskInput').val();\r\n                if (taskText !== '') {\r\n                    var taskItem = '<li>' + taskText + \r\n                                   '<span class="edit-task">[Edit]</span>' +\r\n                                   '<span class="delete-task">[Delete]</span></li>';\r\n                    $('#todo-list').append(taskItem);\r\n                    $('#taskInput').val(''); // Clear input field\r\n                }\r\n            });\r\n\r\n            // Delete Task\r\n            $('#todo-list').on('click', '.delete-task', function() {\r\n                $(this).parent().remove();\r\n            });\r\n\r\n            // Edit Task\r\n            $('#todo-list').on('click', '.edit-task', function() {\r\n                var currentTask = $(this).parent().text().replace('[Edit][Delete]', '').trim();\r\n                var newTask = prompt('Edit Task:', currentTask);\r\n                if (newTask) {\r\n                    $(this).parent().html(newTask + \r\n                                          '<span class="edit-task">[Edit]</span>' +\r\n                                          '<span class="delete-task">[Delete]</span>');\r\n                }\r\n            });\r\n        });\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n- **Add Task**: When the "Add Task" button is clicked, the task input value is retrieved and appended to the `#todo-list` as a new list item. Each task includes "Edit" and "Delete" options.\r\n- **Delete Task**: Clicking the "Delete" button next to a task removes it from the list using the `remove()` method.\r\n- **Edit Task**: Clicking the "Edit" button opens a prompt allowing the user to modify the task's content. Once edited, the new value replaces the old one, and the "Edit" and "Delete" buttons are restored.\r\n\r\n**Key jQuery Features Used**:\r\n- **text()**: Used to retrieve the text of a task for editing.\r\n- **append()**: Adds new tasks to the to-do list.\r\n- **remove()**: Deletes tasks from the list.\r\n- **on()**: Delegates click events for dynamically added elements like the Edit and Delete buttons.\r\n\r\nThis simple To-Do List app demonstrates how jQuery's DOM manipulation methods make it easy to add, modify, and delete elements dynamically in response to user actions.	2024-09-17 17:53:25.056028+00	jquery-dom-manipulation	2
10	jQuery Traversing	### 6. **jQuery Traversing**\r\n\r\njQuery provides several methods for traversing the DOM, which allow you to find and interact with elements relative to other elements. Traversing is especially useful when you need to access elements based on their relationship with other elements (e.g., parents, children, siblings). Understanding these traversal methods is key for building dynamic and interactive interfaces.\r\n\r\n#### Finding Elements\r\n\r\n- **parent()**: Selects the immediate parent of the selected element.\r\n    ```javascript\r\n    $('#child-element').parent();\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<div id="parent">\r\n    <div id="child">This is the child</div>\r\n</div>\r\n<button id="findParent">Find Parent</button>\r\n\r\n<script>\r\n    $('#findParent').click(function() {\r\n        $('#child').parent().css('border', '2px solid red');\r\n    });\r\n</script>\r\n```\r\nHere, clicking the "Find Parent" button highlights the parent of the `#child` element by adding a red border to it.\r\n\r\n- **children()**: Selects all the direct child elements of the selected element.\r\n    ```javascript\r\n    $('#parent-element').children();\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<div id="parent">\r\n    <div class="child">Child 1</div>\r\n    <div class="child">Child 2</div>\r\n</div>\r\n<button id="findChildren">Find Children</button>\r\n\r\n<script>\r\n    $('#findChildren').click(function() {\r\n        $('#parent').children('.child').css('background-color', 'yellow');\r\n    });\r\n</script>\r\n```\r\nClicking the "Find Children" button will highlight all direct child elements of the `#parent` div by changing their background color to yellow.\r\n\r\n- **siblings()**: Selects all sibling elements (elements sharing the same parent) of the selected element.\r\n    ```javascript\r\n    $('#element').siblings();\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<div>\r\n    <p class="item">Item 1</p>\r\n    <p class="item">Item 2</p>\r\n    <p id="selectedItem" class="item">Selected Item</p>\r\n    <p class="item">Item 3</p>\r\n</div>\r\n<button id="highlightSiblings">Highlight Siblings</button>\r\n\r\n<script>\r\n    $('#highlightSiblings').click(function() {\r\n        $('#selectedItem').siblings().css('background-color', 'lightgreen');\r\n    });\r\n</script>\r\n```\r\nIn this example, when the button is clicked, all the siblings of the `#selectedItem` will be highlighted with a light green background.\r\n\r\n#### Filtering\r\n\r\n- **filter()**: Filters elements based on a specified condition, returning only the elements that match.\r\n    ```javascript\r\n    $('li').filter('.active');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<ul>\r\n    <li>Item 1</li>\r\n    <li class="active">Item 2 (Active)</li>\r\n    <li>Item 3</li>\r\n    <li class="active">Item 4 (Active)</li>\r\n</ul>\r\n<button id="filterActive">Filter Active Items</button>\r\n\r\n<script>\r\n    $('#filterActive').click(function() {\r\n        $('li').filter('.active').css('font-weight', 'bold');\r\n    });\r\n</script>\r\n```\r\nWhen the button is clicked, only the items with the class `active` will be bolded.\r\n\r\n- **not()**: Excludes elements that match a specified condition from the selection.\r\n    ```javascript\r\n    $('li').not('.disabled');\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<ul>\r\n    <li>Item 1</li>\r\n    <li class="disabled">Item 2 (Disabled)</li>\r\n    <li>Item 3</li>\r\n    <li class="disabled">Item 4 (Disabled)</li>\r\n</ul>\r\n<button id="highlightNotDisabled">Highlight Non-Disabled</button>\r\n\r\n<script>\r\n    $('#highlightNotDisabled').click(function() {\r\n        $('li').not('.disabled').css('background-color', 'lightblue');\r\n    });\r\n</script>\r\n```\r\nIn this case, clicking the button will highlight all list items that do not have the `disabled` class.\r\n\r\n- **eq()**: Selects the element at the specified index in a set of matched elements.\r\n    ```javascript\r\n    $('li').eq(2);\r\n    ```\r\n\r\n##### Example:\r\n```html\r\n<ul>\r\n    <li>Item 1</li>\r\n    <li>Item 2</li>\r\n    <li>Item 3</li>\r\n    <li>Item 4</li>\r\n</ul>\r\n<button id="selectThird">Select Third Item</button>\r\n\r\n<script>\r\n    $('#selectThird').click(function() {\r\n        $('li').eq(2).css('color', 'red');\r\n    });\r\n</script>\r\n```\r\nWhen you click the button, only the third item in the list will turn red, as `eq(2)` targets the element at index 2 (0-based index).\r\n\r\n---\r\n\r\n### Mini Project: **Interactive Table**\r\n\r\n**Goal**: Build an interactive table where users can highlight specific rows or cells based on their input using jQuery traversal methods.\r\n\r\n#### HTML Structure:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Interactive Table</title>\r\n    <style>\r\n        table {\r\n            width: 100%;\r\n            border-collapse: collapse;\r\n        }\r\n        th, td {\r\n            padding: 10px;\r\n            border: 1px solid #ccc;\r\n        }\r\n        .highlight {\r\n            background-color: yellow;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n\r\n    <h1>Interactive Table</h1>\r\n    <table id="data-table">\r\n        <thead>\r\n            <tr>\r\n                <th>Name</th>\r\n                <th>Age</th>\r\n                <th>City</th>\r\n            </tr>\r\n        </thead>\r\n        <tbody>\r\n            <tr>\r\n                <td>John</td>\r\n                <td>25</td>\r\n                <td>New York</td>\r\n            </tr>\r\n            <tr>\r\n                <td>Jane</td>\r\n                <td>30</td>\r\n                <td>Los Angeles</td>\r\n            </tr>\r\n            <tr>\r\n                <td>Bob</td>\r\n                <td>35</td>\r\n                <td>Chicago</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n\r\n    <label for="rowNumber">Enter Row Number to Highlight:</label>\r\n    <input type="number" id="rowNumber" min="1" max="3">\r\n    <button id="highlightRow">Highlight Row</button>\r\n\r\n    <br><br>\r\n\r\n    <label for="columnNumber">Enter Column Number to Highlight:</label>\r\n    <input type="number" id="columnNumber" min="1" max="3">\r\n    <button id="highlightColumn">Highlight Column</button>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            // Highlight Row\r\n            $('#highlightRow').click(function() {\r\n                var rowNum = $('#rowNumber').val() - 1; // Convert to 0-based index\r\n                $('#data-table tbody tr').removeClass('highlight'); // Remove previous highlights\r\n                $('#data-table tbody tr').eq(rowNum).addClass('highlight');\r\n            });\r\n\r\n            // Highlight Column\r\n            $('#highlightColumn').click(function() {\r\n                var colNum = $('#columnNumber').val() - 1; // Convert to 0-based index\r\n                $('#data-table td').removeClass('highlight'); // Remove previous highlights\r\n                $('#data-table tbody tr').each(function() {\r\n                    $(this).find('td').eq(colNum).addClass('highlight');\r\n                });\r\n            });\r\n        });\r\n    </script>\r\n\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n- **Highlight Row**: \r\n  - The user inputs a row number in the text field.\r\n  - The `eq()` method is used to select the row at the entered index (adjusted to 0-based index). The row is then highlighted by adding the `highlight` class, which changes the background color to yellow.\r\n  - `removeClass('highlight')` is used to remove previous highlights before applying a new one.\r\n\r\n- **Highlight Column**:\r\n  - The user inputs a column number in the text field.\r\n  - The `eq()` method is used inside a loop (`each()`) to highlight the specific column across all rows.\r\n  - As with rows, previous highlights are removed before the new highlight is applied.\r\n\r\n**Key jQuery Features Used**:\r\n- **eq()**: To select specific rows or columns based on user input.\r\n- **each()**: To iterate over each row of the table when highlighting a column.\r\n- **removeClass() / addClass()**: To dynamically manage the highlighting by adding/removing the `highlight` class.\r\n\r\nThis interactive table project showcases how jQuery traversal methods can be used to dynamically select and modify specific parts of the DOM based on user input, making the interface more interactive and user-friendly.	2024-09-17 17:54:20.120266+00	jquery-traversing	2
12	jQuery Plugins	### 8. **jQuery Plugins**\r\n\r\njQuery plugins are reusable pieces of code that extend jQuery’s functionality by offering specific, pre-built features or components that you can easily integrate into your projects. Plugins make it easy to add advanced interactions or functionality to your site without needing to build everything from scratch.\r\n\r\n#### What are Plugins?\r\n\r\nA **jQuery plugin** is simply a reusable library built on top of jQuery, which can be included in any project to perform tasks like form validation, image sliders, animations, etc. Instead of writing all the functionality yourself, you include the plugin and use its predefined methods or functions.\r\n\r\n**Benefits of using jQuery plugins**:\r\n- **Save Time and Effort**: Plugins provide pre-built solutions for common tasks.\r\n- **Customization**: Many plugins offer options for customization, so you can modify them to suit your project’s needs.\r\n- **Community Support**: Popular plugins are usually well-documented and supported by a large community of developers.\r\n  \r\n**Example**: Let's say you want to implement an image carousel. Instead of writing your own slider functionality, you can use an existing plugin like Slick or Owl Carousel to handle it with minimal effort.\r\n\r\n#### Popular jQuery Plugins\r\n\r\nHere are some of the most commonly used jQuery plugins:\r\n\r\n1. **Slick Carousel**: A widely used plugin for creating responsive, touch-friendly sliders.\r\n2. **Owl Carousel**: Another responsive and touch-friendly carousel/slider plugin.\r\n3. **jQuery UI**: A collection of GUI widgets, including sliders, date pickers, and more.\r\n4. **Lightbox**: A popular plugin for displaying images or galleries in a modal window.\r\n5. **DataTables**: A plugin that enhances HTML tables with features like sorting, pagination, and filtering.\r\n\r\n#### How to Include and Use Plugins\r\n\r\nUsing a jQuery plugin usually involves the following steps:\r\n\r\n1. **Download or Link to the Plugin**: You can either download the plugin files or link to them via a CDN (Content Delivery Network).\r\n2. **Include the Plugin’s CSS and JS Files**: Include the necessary CSS and JavaScript files in your HTML.\r\n3. **Initialize the Plugin**: Write a simple jQuery code snippet to initialize and configure the plugin according to your needs.\r\n\r\n##### Example: Using the Slick Carousel Plugin\r\n\r\n1. **Include the necessary files**:\r\n   ```html\r\n   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>\r\n   <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n   <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>\r\n   ```\r\n\r\n2. **HTML Structure**:\r\n   ```html\r\n   <div class="carousel">\r\n       <div><img src="image1.jpg" alt="Image 1"></div>\r\n       <div><img src="image2.jpg" alt="Image 2"></div>\r\n       <div><img src="image3.jpg" alt="Image 3"></div>\r\n   </div>\r\n   ```\r\n\r\n3. **Initialize the Slick plugin**:\r\n   ```javascript\r\n   $(document).ready(function(){\r\n       $('.carousel').slick({\r\n           autoplay: true,\r\n           autoplaySpeed: 2000,\r\n           dots: true,\r\n           arrows: true\r\n       });\r\n   });\r\n   ```\r\n\r\nIn this example:\r\n- **autoplay**: Automatically transitions between images every 2 seconds.\r\n- **dots**: Enables the navigation dots below the carousel.\r\n- **arrows**: Enables the navigation arrows to manually switch between images.\r\n\r\n#### Mini Project: **Image Carousel**\r\n\r\n**Goal**: Implement a dynamic image carousel using a jQuery plugin like Slick or Owl Carousel.\r\n\r\n---\r\n\r\n#### Steps:\r\n\r\n1. **Select a Plugin**: For this project, we will use the **Slick Carousel** plugin to implement an image carousel.\r\n2. **Setup Your HTML Structure**: Create a div to hold the images.\r\n3. **Include Plugin Files**: Add the necessary CSS and JS files for the plugin.\r\n4. **Initialize the Plugin**: Write a jQuery function to initialize the plugin and customize its options.\r\n\r\n---\r\n\r\n### Example Code: Image Carousel with Slick\r\n\r\n##### HTML Structure:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Image Carousel</title>\r\n    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>\r\n    <style>\r\n        .carousel img {\r\n            width: 100%;\r\n            height: auto;\r\n        }\r\n        .carousel {\r\n            width: 80%;\r\n            margin: 0 auto;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n\r\n    <h1>Dynamic Image Carousel</h1>\r\n    <div class="carousel">\r\n        <div><img src="https://via.placeholder.com/800x400?text=Image+1" alt="Image 1"></div>\r\n        <div><img src="https://via.placeholder.com/800x400?text=Image+2" alt="Image 2"></div>\r\n        <div><img src="https://via.placeholder.com/800x400?text=Image+3" alt="Image 3"></div>\r\n    </div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>\r\n    <script>\r\n        $(document).ready(function(){\r\n            $('.carousel').slick({\r\n                autoplay: true,\r\n                autoplaySpeed: 3000,\r\n                dots: true,\r\n                arrows: true,\r\n                infinite: true,\r\n                speed: 500,\r\n                fade: true,\r\n                cssEase: 'linear'\r\n            });\r\n        });\r\n    </script>\r\n\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n\r\n1. **HTML Structure**: \r\n   - The images are placed inside divs, and all the divs are wrapped inside the main `carousel` div.\r\n   - You can replace the placeholder images with your actual images by changing the `src` attribute.\r\n\r\n2. **Including the Plugin**:\r\n   - The Slick carousel's CSS and JS files are included using a CDN.\r\n\r\n3. **Initialization**:\r\n   - The `.slick()` function initializes the carousel and sets its options:\r\n     - **autoplay**: The carousel slides automatically.\r\n     - **autoplaySpeed**: The time between slides (in milliseconds).\r\n     - **dots**: Displays navigation dots at the bottom of the carousel.\r\n     - **arrows**: Shows left and right arrows for manual navigation.\r\n     - **infinite**: The carousel loops back to the first slide when it reaches the last.\r\n     - **fade**: The images fade in and out instead of sliding horizontally.\r\n\r\n---\r\n\r\n### Summary:\r\n\r\n- **What are Plugins?**: jQuery plugins are reusable, pre-built solutions that can be easily integrated into your web projects to add functionality like sliders, forms, animations, etc.\r\n  \r\n- **Popular jQuery Plugins**: Plugins like Slick Carousel, Owl Carousel, jQuery UI, and DataTables make it easy to implement advanced features without writing extensive code.\r\n\r\n- **How to Use Plugins**: Plugins are included by linking to their CSS and JavaScript files, and then initialized using a jQuery function.\r\n\r\n**Mini Project: Image Carousel** demonstrates how to use the Slick plugin to create a dynamic, responsive image slider on your website.	2024-09-17 17:55:24.022026+00	jquery-plugins	2
13	jQuery Plugins	### 8. **jQuery Plugins**\r\n\r\njQuery plugins are reusable pieces of code that extend jQuery’s functionality by offering specific, pre-built features or components that you can easily integrate into your projects. Plugins make it easy to add advanced interactions or functionality to your site without needing to build everything from scratch.\r\n\r\n#### What are Plugins?\r\n\r\nA **jQuery plugin** is simply a reusable library built on top of jQuery, which can be included in any project to perform tasks like form validation, image sliders, animations, etc. Instead of writing all the functionality yourself, you include the plugin and use its predefined methods or functions.\r\n\r\n**Benefits of using jQuery plugins**:\r\n- **Save Time and Effort**: Plugins provide pre-built solutions for common tasks.\r\n- **Customization**: Many plugins offer options for customization, so you can modify them to suit your project’s needs.\r\n- **Community Support**: Popular plugins are usually well-documented and supported by a large community of developers.\r\n  \r\n**Example**: Let's say you want to implement an image carousel. Instead of writing your own slider functionality, you can use an existing plugin like Slick or Owl Carousel to handle it with minimal effort.\r\n\r\n#### Popular jQuery Plugins\r\n\r\nHere are some of the most commonly used jQuery plugins:\r\n\r\n1. **Slick Carousel**: A widely used plugin for creating responsive, touch-friendly sliders.\r\n2. **Owl Carousel**: Another responsive and touch-friendly carousel/slider plugin.\r\n3. **jQuery UI**: A collection of GUI widgets, including sliders, date pickers, and more.\r\n4. **Lightbox**: A popular plugin for displaying images or galleries in a modal window.\r\n5. **DataTables**: A plugin that enhances HTML tables with features like sorting, pagination, and filtering.\r\n\r\n#### How to Include and Use Plugins\r\n\r\nUsing a jQuery plugin usually involves the following steps:\r\n\r\n1. **Download or Link to the Plugin**: You can either download the plugin files or link to them via a CDN (Content Delivery Network).\r\n2. **Include the Plugin’s CSS and JS Files**: Include the necessary CSS and JavaScript files in your HTML.\r\n3. **Initialize the Plugin**: Write a simple jQuery code snippet to initialize and configure the plugin according to your needs.\r\n\r\n##### Example: Using the Slick Carousel Plugin\r\n\r\n1. **Include the necessary files**:\r\n   ```html\r\n   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>\r\n   <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n   <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>\r\n   ```\r\n\r\n2. **HTML Structure**:\r\n   ```html\r\n   <div class="carousel">\r\n       <div><img src="image1.jpg" alt="Image 1"></div>\r\n       <div><img src="image2.jpg" alt="Image 2"></div>\r\n       <div><img src="image3.jpg" alt="Image 3"></div>\r\n   </div>\r\n   ```\r\n\r\n3. **Initialize the Slick plugin**:\r\n   ```javascript\r\n   $(document).ready(function(){\r\n       $('.carousel').slick({\r\n           autoplay: true,\r\n           autoplaySpeed: 2000,\r\n           dots: true,\r\n           arrows: true\r\n       });\r\n   });\r\n   ```\r\n\r\nIn this example:\r\n- **autoplay**: Automatically transitions between images every 2 seconds.\r\n- **dots**: Enables the navigation dots below the carousel.\r\n- **arrows**: Enables the navigation arrows to manually switch between images.\r\n\r\n#### Mini Project: **Image Carousel**\r\n\r\n**Goal**: Implement a dynamic image carousel using a jQuery plugin like Slick or Owl Carousel.\r\n\r\n---\r\n\r\n#### Steps:\r\n\r\n1. **Select a Plugin**: For this project, we will use the **Slick Carousel** plugin to implement an image carousel.\r\n2. **Setup Your HTML Structure**: Create a div to hold the images.\r\n3. **Include Plugin Files**: Add the necessary CSS and JS files for the plugin.\r\n4. **Initialize the Plugin**: Write a jQuery function to initialize the plugin and customize its options.\r\n\r\n---\r\n\r\n### Example Code: Image Carousel with Slick\r\n\r\n##### HTML Structure:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Image Carousel</title>\r\n    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>\r\n    <style>\r\n        .carousel img {\r\n            width: 100%;\r\n            height: auto;\r\n        }\r\n        .carousel {\r\n            width: 80%;\r\n            margin: 0 auto;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n\r\n    <h1>Dynamic Image Carousel</h1>\r\n    <div class="carousel">\r\n        <div><img src="https://via.placeholder.com/800x400?text=Image+1" alt="Image 1"></div>\r\n        <div><img src="https://via.placeholder.com/800x400?text=Image+2" alt="Image 2"></div>\r\n        <div><img src="https://via.placeholder.com/800x400?text=Image+3" alt="Image 3"></div>\r\n    </div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>\r\n    <script>\r\n        $(document).ready(function(){\r\n            $('.carousel').slick({\r\n                autoplay: true,\r\n                autoplaySpeed: 3000,\r\n                dots: true,\r\n                arrows: true,\r\n                infinite: true,\r\n                speed: 500,\r\n                fade: true,\r\n                cssEase: 'linear'\r\n            });\r\n        });\r\n    </script>\r\n\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n\r\n1. **HTML Structure**: \r\n   - The images are placed inside divs, and all the divs are wrapped inside the main `carousel` div.\r\n   - You can replace the placeholder images with your actual images by changing the `src` attribute.\r\n\r\n2. **Including the Plugin**:\r\n   - The Slick carousel's CSS and JS files are included using a CDN.\r\n\r\n3. **Initialization**:\r\n   - The `.slick()` function initializes the carousel and sets its options:\r\n     - **autoplay**: The carousel slides automatically.\r\n     - **autoplaySpeed**: The time between slides (in milliseconds).\r\n     - **dots**: Displays navigation dots at the bottom of the carousel.\r\n     - **arrows**: Shows left and right arrows for manual navigation.\r\n     - **infinite**: The carousel loops back to the first slide when it reaches the last.\r\n     - **fade**: The images fade in and out instead of sliding horizontally.\r\n\r\n---\r\n\r\n### Summary:\r\n\r\n- **What are Plugins?**: jQuery plugins are reusable, pre-built solutions that can be easily integrated into your web projects to add functionality like sliders, forms, animations, etc.\r\n  \r\n- **Popular jQuery Plugins**: Plugins like Slick Carousel, Owl Carousel, jQuery UI, and DataTables make it easy to implement advanced features without writing extensive code.\r\n\r\n- **How to Use Plugins**: Plugins are included by linking to their CSS and JavaScript files, and then initialized using a jQuery function.\r\n\r\n**Mini Project: Image Carousel** demonstrates how to use the Slick plugin to create a dynamic, responsive image slider on your website.	2024-09-17 17:55:26.082682+00	jquery-plugins-2	2
11	jQuery AJAX	### 7. **jQuery AJAX**\r\n\r\nAJAX (Asynchronous JavaScript and XML) allows you to asynchronously load and send data to/from a server without having to reload the page. jQuery simplifies the use of AJAX by providing easy-to-use methods to interact with servers and external APIs. It’s especially useful for creating dynamic web applications that need to communicate with a server behind the scenes.\r\n\r\n#### AJAX Introduction and Benefits\r\n\r\nAJAX allows web pages to be updated asynchronously by exchanging small amounts of data with the server. This means that parts of a web page can be updated without requiring a full page reload.\r\n\r\n**Benefits of AJAX**:\r\n- **Asynchronous Communication**: Page elements can be updated in the background without blocking other interactions.\r\n- **Faster and More Responsive UIs**: By only loading necessary data, you reduce the need for complete page refreshes.\r\n- **Improved User Experience**: AJAX enables features like instant form validation, infinite scrolling, and live data updates.\r\n\r\n#### Loading External Data\r\n\r\njQuery provides several methods to load data from a server or an API:\r\n- **load()**: Loads data from the server and places it into a specific element.\r\n- **get()**: Sends an HTTP GET request to retrieve data from a server.\r\n- **post()**: Sends an HTTP POST request to send data to a server.\r\n\r\n##### Example: Using `load()`\r\n```html\r\n<div id="content"></div>\r\n<button id="loadData">Load Data</button>\r\n\r\n<script>\r\n    $('#loadData').click(function() {\r\n        $('#content').load('data.html');\r\n    });\r\n</script>\r\n```\r\nIn this example, clicking the "Load Data" button loads the content of `data.html` into the `#content` div using the `load()` method.\r\n\r\n#### Handling JSON with jQuery\r\n\r\nJSON (JavaScript Object Notation) is a lightweight format used for data exchange. jQuery can easily fetch and process JSON data from a server using AJAX methods like `get()` and `post()`.\r\n\r\n##### Example: Using `get()`\r\n```javascript\r\n$.get('https://api.example.com/data', function(response) {\r\n    console.log(response);\r\n});\r\n```\r\nThis sends a GET request to the server, and the response (in JSON format) is logged to the console.\r\n\r\n##### Example: Using `post()`\r\n```javascript\r\n$.post('https://api.example.com/data', { key: 'value' }, function(response) {\r\n    console.log(response);\r\n});\r\n```\r\nHere, a POST request is sent to the server with data `{ key: 'value' }`, and the response is logged to the console.\r\n\r\n### Mini Project: **Weather App**\r\n\r\n**Goal**: Build a small weather app that fetches weather data from a weather API using jQuery AJAX methods.\r\n\r\n#### Steps:\r\n1. **API Integration**: Use a weather API (e.g., OpenWeatherMap) to fetch the current weather based on the user's input (city name).\r\n2. **AJAX Request**: Use jQuery's AJAX methods to send a request to the API and handle the response.\r\n3. **Display Weather**: Show the fetched weather data (temperature, weather condition) on the web page.\r\n\r\n#### Example Code:\r\n\r\n##### HTML Structure:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Weather App</title>\r\n    <style>\r\n        body {\r\n            font-family: Arial, sans-serif;\r\n            text-align: center;\r\n            margin-top: 50px;\r\n        }\r\n        #weatherData {\r\n            margin-top: 20px;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n    <h1>Weather App</h1>\r\n    <input type="text" id="city" placeholder="Enter City Name">\r\n    <button id="getWeather">Get Weather</button>\r\n\r\n    <div id="weatherData"></div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            $('#getWeather').click(function() {\r\n                var city = $('#city').val();\r\n                if (city !== '') {\r\n                    $.ajax({\r\n                        url: 'https://api.openweathermap.org/data/2.5/weather',\r\n                        type: 'GET',\r\n                        dataType: 'json',\r\n                        data: {\r\n                            q: city,\r\n                            appid: 'YOUR_API_KEY',  // Replace with your OpenWeather API key\r\n                            units: 'metric'\r\n                        },\r\n                        success: function(response) {\r\n                            var weatherInfo = `\r\n                                <h3>Weather in ${response.name}</h3>\r\n                                <p>Temperature: ${response.main.temp} °C</p>\r\n                                <p>Condition: ${response.weather[0].description}</p>\r\n                            `;\r\n                            $('#weatherData').html(weatherInfo);\r\n                        },\r\n                        error: function() {\r\n                            $('#weatherData').html('<p>City not found. Please try again.</p>');\r\n                        }\r\n                    });\r\n                } else {\r\n                    $('#weatherData').html('<p>Please enter a city name.</p>');\r\n                }\r\n            });\r\n        });\r\n    </script>\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n\r\n1. **HTML Input and Button**: \r\n   - The user enters a city name in the text input field.\r\n   - Clicking the "Get Weather" button triggers the AJAX request to fetch weather data for the entered city.\r\n\r\n2. **jQuery AJAX Request**:\r\n   - When the button is clicked, an AJAX GET request is made to the OpenWeatherMap API with the city name and an API key.\r\n   - `url`: The endpoint for the weather API.\r\n   - `dataType`: Set to 'json' to indicate that we expect a JSON response.\r\n   - `data`: Contains the query parameters like the city name, API key, and units of measurement (Celsius in this case).\r\n   - **Success**: If the request is successful, the response (weather data) is displayed in the `#weatherData` div.\r\n   - **Error Handling**: If the city is not found or the request fails, an error message is displayed.\r\n\r\n3. **API Key**: You will need to replace `YOUR_API_KEY` with your actual OpenWeather API key, which you can get by signing up on [OpenWeatherMap](https://openweathermap.org/).\r\n\r\n4. **Weather Data Display**:\r\n   - The app displays the city name, temperature (in Celsius), and weather condition (e.g., cloudy, sunny) on the page.\r\n\r\n#### Summary:\r\n\r\n- **AJAX Methods Used**:\r\n  - **`$.ajax()`**: A flexible AJAX method used for making requests.\r\n  - **Success and Error Callbacks**: To handle the API response or any potential errors.\r\n  \r\nThis small weather app demonstrates the power of jQuery AJAX methods for creating dynamic, API-driven applications. By fetching live data from an external server and displaying it on the web page, you can enhance the user experience and build more interactive web applications.	2024-09-17 17:54:55.198104+00	jquery-ajax	2
14	jQuery UI	### 9. **jQuery UI**\r\n\r\n**jQuery UI** is a curated set of user interface interactions, effects, widgets, and themes built on top of the jQuery JavaScript Library. It provides a lot of pre-made components that are easy to integrate into web applications, helping developers quickly add sophisticated UI elements to their projects without writing complex code.\r\n\r\n#### Introduction to jQuery UI\r\n\r\n**jQuery UI** adds interactivity to your website with a wide range of features:\r\n- **Interactions**: Add drag-and-drop, sorting, and resizing capabilities to elements.\r\n- **Widgets**: Ready-to-use UI components like accordions, date pickers, sliders, and tabs.\r\n- **Effects**: Animated effects like showing/hiding, bouncing, and sliding.\r\n\r\nTo start using jQuery UI, you can include it in your project by linking to the jQuery UI CDN:\r\n\r\n```html\r\n<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">\r\n<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>\r\n```\r\n\r\n#### Draggable and Droppable\r\n\r\n**Draggable**: The draggable interaction makes an element movable by clicking and dragging it around.\r\n\r\n##### Example: Making an Element Draggable\r\n```html\r\n<div id="draggable" style="width: 100px; height: 100px; background-color: blue;">Drag me</div>\r\n\r\n<script>\r\n  $(function() {\r\n    $("#draggable").draggable();\r\n  });\r\n</script>\r\n```\r\n\r\nIn this example, the element with the id `draggable` becomes movable within the browser window using the `draggable()` method.\r\n\r\n**Droppable**: You can combine draggable elements with droppable areas, which respond when a draggable element is dropped onto them.\r\n\r\n##### Example: Making an Element Droppable\r\n```html\r\n<div id="draggable" style="width: 100px; height: 100px; background-color: blue;">Drag me</div>\r\n<div id="droppable" style="width: 200px; height: 200px; background-color: lightgrey; margin-top: 20px;">Drop here</div>\r\n\r\n<script>\r\n  $(function() {\r\n    $("#draggable").draggable();\r\n    $("#droppable").droppable({\r\n      drop: function(event, ui) {\r\n        $(this).css("background-color", "green").html("Dropped!");\r\n      }\r\n    });\r\n  });\r\n</script>\r\n```\r\n\r\nHere, when the blue `#draggable` element is dropped onto the `#droppable` area, the background color of `#droppable` changes to green, and the text inside it updates to say "Dropped!".\r\n\r\n#### Accordion and Tabs\r\n\r\n**Accordion**: The accordion widget allows you to create collapsible sections, useful for FAQs or content that you want to reveal in pieces.\r\n\r\n##### Example: Accordion\r\n```html\r\n<div id="accordion">\r\n  <h3>Section 1</h3>\r\n  <div>\r\n    <p>Content for section 1.</p>\r\n  </div>\r\n  <h3>Section 2</h3>\r\n  <div>\r\n    <p>Content for section 2.</p>\r\n  </div>\r\n</div>\r\n\r\n<script>\r\n  $(function() {\r\n    $("#accordion").accordion();\r\n  });\r\n</script>\r\n```\r\n\r\nIn this example, `#accordion` is turned into a collapsible, multi-section interface where only one section is open at a time.\r\n\r\n**Tabs**: Tabs organize content into sections, allowing users to navigate between different parts of the content without reloading the page.\r\n\r\n##### Example: Tabs\r\n```html\r\n<div id="tabs">\r\n  <ul>\r\n    <li><a href="#tab-1">Tab 1</a></li>\r\n    <li><a href="#tab-2">Tab 2</a></li>\r\n  </ul>\r\n  <div id="tab-1">\r\n    <p>Content for Tab 1</p>\r\n  </div>\r\n  <div id="tab-2">\r\n    <p>Content for Tab 2</p>\r\n  </div>\r\n</div>\r\n\r\n<script>\r\n  $(function() {\r\n    $("#tabs").tabs();\r\n  });\r\n</script>\r\n```\r\n\r\nIn this example, you create a simple tabbed interface, where clicking the tab headers will reveal the content in the associated section.\r\n\r\n#### Datepicker\r\n\r\n**Datepicker**: The datepicker widget adds a calendar popup to input fields, allowing users to pick a date. It’s commonly used in forms for selecting dates in a user-friendly way.\r\n\r\n##### Example: Datepicker\r\n```html\r\n<label for="date">Select a date:</label>\r\n<input type="text" id="date">\r\n\r\n<script>\r\n  $(function() {\r\n    $("#date").datepicker();\r\n  });\r\n</script>\r\n```\r\n\r\nHere, the `#date` input field is converted into a date picker. When clicked, a calendar pops up, allowing the user to select a date.\r\n\r\n---\r\n\r\n### Mini Project: **Event Scheduler**\r\n\r\n**Goal**: Build a simple event scheduling app that allows users to pick dates using the jQuery UI Datepicker and drag-and-drop events to time slots using the Draggable and Droppable features.\r\n\r\n#### Steps:\r\n1. **Set Up Datepicker for Date Selection**: Allow users to select dates for scheduling events.\r\n2. **Use Draggable for Events**: Make event cards draggable, so users can drag them onto the schedule.\r\n3. **Use Droppable for Time Slots**: Create droppable time slots where users can place their events.\r\n\r\n---\r\n\r\n### Example Code: Event Scheduler\r\n\r\n##### HTML Structure:\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Event Scheduler</title>\r\n    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">\r\n    <style>\r\n        .event {\r\n            width: 150px;\r\n            padding: 10px;\r\n            margin-bottom: 10px;\r\n            background-color: #3498db;\r\n            color: white;\r\n            cursor: move;\r\n        }\r\n        .time-slot {\r\n            width: 200px;\r\n            height: 50px;\r\n            margin-bottom: 20px;\r\n            background-color: #ecf0f1;\r\n            border: 2px dashed #bdc3c7;\r\n        }\r\n        .schedule {\r\n            margin-top: 20px;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n\r\n    <h1>Event Scheduler</h1>\r\n\r\n    <!-- Datepicker for selecting date -->\r\n    <label for="event-date">Select Event Date:</label>\r\n    <input type="text" id="event-date">\r\n\r\n    <h2>Events</h2>\r\n    <!-- Draggable event cards -->\r\n    <div class="event" id="event1">Meeting with John</div>\r\n    <div class="event" id="event2">Project Deadline</div>\r\n\r\n    <h2>Schedule</h2>\r\n    <!-- Droppable time slots -->\r\n    <div class="schedule">\r\n        <div class="time-slot" id="slot1">9:00 AM - 10:00 AM</div>\r\n        <div class="time-slot" id="slot2">10:00 AM - 11:00 AM</div>\r\n    </div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>\r\n    <script>\r\n        $(function() {\r\n            // Datepicker initialization\r\n            $("#event-date").datepicker();\r\n\r\n            // Make events draggable\r\n            $(".event").draggable({\r\n                revert: "invalid", // Revert if not dropped on valid target\r\n                helper: "clone"\r\n            });\r\n\r\n            // Make time slots droppable\r\n            $(".time-slot").droppable({\r\n                accept: ".event",\r\n                drop: function(event, ui) {\r\n                    $(this).html("Scheduled: " + ui.draggable.text())\r\n                           .css("background-color", "#2ecc71");\r\n                }\r\n            });\r\n        });\r\n    </script>\r\n\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n\r\n1. **Datepicker**:\r\n   - The user can select the event date using the `#event-date` input field, which is linked to the jQuery UI Datepicker.\r\n   \r\n2. **Draggable Events**:\r\n   - The two event cards (Meeting with John and Project Deadline) are draggable. The `revert: "invalid"` option ensures that the events return to their original position if they’re not dropped on a valid time slot.\r\n   - The `helper: "clone"` option creates a visual clone when dragging.\r\n\r\n3. **Droppable Time Slots**:\r\n   - The time slots are droppable areas where users can drop events.\r\n   - When an event is dropped into a time slot, the text inside the time slot updates to show the event name, and the background color changes to green to indicate the event is scheduled.\r\n\r\n---\r\n\r\n### Summary:\r\n\r\n- **jQuery UI** provides a wide range of widgets and interactions that enhance user interfaces without writing complex code from scratch.\r\n- **Draggable and Droppable**: Add drag-and-drop capabilities to elements, allowing users to move items around the page or into specific drop zones.\r\n- **Accordion and Tabs**: Organize content into collapsible or tabbed sections for better usability.\r\n- **Datepicker**: Allow users to easily select dates in a user-friendly way with a calendar popup.\r\n\r\n**Mini Project: Event Scheduler** demonstrates how you can combine multiple jQuery UI features—such as the Datepicker, Draggable	2024-09-17 18:00:41.372993+00	jquery-ui	1
15	jQuery Performance Optimization	### 10. **jQuery Performance Optimization**\r\n\r\nPerformance optimization is crucial in web development to ensure that applications run smoothly and efficiently, even when dealing with large amounts of data or complex user interactions. jQuery, while powerful and easy to use, can sometimes lead to performance issues if not used wisely. Here’s how to optimize jQuery operations to improve your webpage’s performance.\r\n\r\n#### Minimizing jQuery Operations\r\n\r\nEvery jQuery operation (like querying the DOM, adding or removing elements) can be resource-intensive, especially if repeated frequently. Reducing the number of operations can significantly improve performance.\r\n\r\n**Best Practices:**\r\n- **Batch Operations**: Instead of performing multiple jQuery operations one after another, batch them together when possible.\r\n- **Avoid Redundant Selections**: If you need to access the same element multiple times, cache the jQuery object rather than querying the DOM repeatedly.\r\n\r\n##### Example: Minimizing jQuery Operations\r\n```javascript\r\n// Inefficient\r\n$('#element1').css('color', 'red');\r\n$('#element1').css('background-color', 'blue');\r\n\r\n// Efficient\r\nvar $element = $('#element1');\r\n$element.css({\r\n  'color': 'red',\r\n  'background-color': 'blue'\r\n});\r\n```\r\n\r\nIn this example, we cache the jQuery object in a variable `$element` and apply multiple CSS changes in a single call, reducing the number of jQuery operations.\r\n\r\n#### Caching Selectors\r\n\r\nEvery time you use a jQuery selector (e.g., `$('#myDiv')`), jQuery traverses the DOM to find the matching elements. If you use the same selector multiple times, cache it in a variable to avoid redundant DOM queries.\r\n\r\n##### Example: Caching Selectors\r\n```javascript\r\n// Inefficient\r\n$('#myDiv').hide();\r\n$('#myDiv').css('color', 'red');\r\n$('#myDiv').text('Hello');\r\n\r\n// Efficient\r\nvar $myDiv = $('#myDiv');\r\n$myDiv.hide();\r\n$myDiv.css('color', 'red');\r\n$myDiv.text('Hello');\r\n```\r\n\r\nHere, we cache the result of `$('#myDiv')` in the `$myDiv` variable and use it for all subsequent operations, which is more efficient.\r\n\r\n#### Using Document Fragment\r\n\r\nWhen you need to add or remove a large number of elements, it’s more efficient to use a **document fragment**. A document fragment is a lightweight container that is not part of the DOM. You can append elements to the fragment, and then append the fragment to the DOM in a single operation.\r\n\r\n##### Example: Using Document Fragment\r\n```javascript\r\nvar $fragment = $(document.createDocumentFragment());\r\n\r\n// Append multiple elements to the fragment\r\nfor (var i = 0; i < 100; i++) {\r\n  $('<div>').text('Item ' + i).appendTo($fragment);\r\n}\r\n\r\n// Append the fragment to the DOM in one go\r\n$('#container').append($fragment);\r\n```\r\n\r\nIn this example, we create a document fragment and append 100 `<div>` elements to it. Only after all elements are added do we append the fragment to the DOM, which is more efficient than appending each element individually.\r\n\r\n#### Debouncing and Throttling Events\r\n\r\nWhen dealing with events that fire frequently, such as `scroll`, `resize`, or `input`, it’s important to control the rate at which event handlers execute to avoid performance issues.\r\n\r\n**Debouncing**: Ensures that a function is executed only after a certain amount of time has passed since the last time the function was invoked. Useful for events that fire rapidly, like `input` changes.\r\n\r\n**Throttling**: Limits the execution of a function to a maximum number of times per interval. Useful for events that fire continuously, like `scroll`.\r\n\r\n##### Example: Debouncing\r\n```javascript\r\nfunction debounce(func, wait) {\r\n  var timeout;\r\n  return function() {\r\n    clearTimeout(timeout);\r\n    timeout = setTimeout(func, wait);\r\n  };\r\n}\r\n\r\n// Usage\r\n$(window).on('resize', debounce(function() {\r\n  console.log('Window resized');\r\n}, 250));\r\n```\r\n\r\nIn this example, the `debounce` function ensures that the resize event handler executes only once every 250 milliseconds, regardless of how often the resize event fires.\r\n\r\n##### Example: Throttling\r\n```javascript\r\nfunction throttle(func, limit) {\r\n  var lastFunc;\r\n  var lastRan;\r\n  return function() {\r\n    var context = this;\r\n    var args = arguments;\r\n    if (!lastRan) {\r\n      func.apply(context, args);\r\n      lastRan = Date.now();\r\n    } else {\r\n      clearTimeout(lastFunc);\r\n      lastFunc = setTimeout(function() {\r\n        if ((Date.now() - lastRan) >= limit) {\r\n          func.apply(context, args);\r\n          lastRan = Date.now();\r\n        }\r\n      }, limit - (Date.now() - lastRan));\r\n    }\r\n  };\r\n}\r\n\r\n// Usage\r\n$(window).on('scroll', throttle(function() {\r\n  console.log('Scrolled');\r\n}, 1000));\r\n```\r\n\r\nIn this example, the `throttle` function limits the scroll event handler to execute once every second, reducing the number of times the function is called.\r\n\r\n---\r\n\r\n### Mini Project: **Optimized Scrolling Webpage**\r\n\r\n**Goal**: Implement a webpage with infinite scrolling, ensuring that heavy DOM updates are optimized for performance.\r\n\r\n#### Steps:\r\n1. **Setup Infinite Scrolling**: Load more content as the user scrolls down the page.\r\n2. **Optimize DOM Updates**: Use techniques like batching DOM updates and document fragments to handle large amounts of data efficiently.\r\n3. **Implement Debouncing/Throttling**: Ensure that the scroll event handler does not execute excessively, which can lead to performance issues.\r\n\r\n##### Example Code: Optimized Scrolling Webpage\r\n\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Infinite Scrolling</title>\r\n    <style>\r\n        #content {\r\n            width: 80%;\r\n            margin: 0 auto;\r\n        }\r\n        .item {\r\n            padding: 20px;\r\n            border-bottom: 1px solid #ddd;\r\n        }\r\n        #loading {\r\n            text-align: center;\r\n            padding: 20px;\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n\r\n    <div id="content">\r\n        <!-- Content will be dynamically loaded here -->\r\n    </div>\r\n    <div id="loading">Loading...</div>\r\n\r\n    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>\r\n    <script>\r\n        var page = 1;\r\n        var loading = false;\r\n\r\n        function loadMoreContent() {\r\n            if (loading) return;\r\n            loading = true;\r\n\r\n            $.ajax({\r\n                url: 'https://example.com/api/items?page=' + page,\r\n                method: 'GET',\r\n                success: function(data) {\r\n                    var $fragment = $(document.createDocumentFragment());\r\n\r\n                    data.items.forEach(function(item) {\r\n                        $('<div class="item">').text(item.content).appendTo($fragment);\r\n                    });\r\n\r\n                    $('#content').append($fragment);\r\n                    page++;\r\n                    loading = false;\r\n                }\r\n            });\r\n        }\r\n\r\n        function onScroll() {\r\n            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {\r\n                loadMoreContent();\r\n            }\r\n        }\r\n\r\n        $(window).on('scroll', _.throttle(onScroll, 200)); // Using lodash's throttle for demonstration\r\n\r\n        // Initial load\r\n        loadMoreContent();\r\n    </script>\r\n\r\n</body>\r\n</html>\r\n```\r\n\r\n#### Explanation:\r\n\r\n1. **Setup Infinite Scrolling**:\r\n   - The `loadMoreContent` function fetches data from a server and appends it to the `#content` div.\r\n   - The `page` variable tracks the current page of data being fetched.\r\n\r\n2. **Optimize DOM Updates**:\r\n   - Data is first added to a document fragment and then appended to the DOM in a single operation to improve performance.\r\n\r\n3. **Debouncing/Throttling**:\r\n   - The `onScroll` function is called only when the user scrolls close to the bottom of the page, and it’s throttled to ensure it doesn’t execute too frequently.\r\n\r\n---\r\n\r\n### Summary:\r\n\r\n- **Minimizing jQuery Operations**: Reduce the number of jQuery operations by batching them and caching selectors to improve performance.\r\n- **Using Document Fragment**: Batch large DOM updates using document fragments to reduce the number of reflows and repaints.\r\n- **Debouncing and Throttling Events**: Control the frequency of event handler execution to avoid performance bottlenecks.\r\n\r\n**Mini Project: Optimized Scrolling Webpage** demonstrates how to implement infinite scrolling with optimized performance, ensuring smooth user experiences even with large datasets.	2024-09-17 18:01:16.433909+00	jquery-performance-optimization	1
16	Final Mini Project: Dynamic Portfolio Website	### Final Mini Project: **Dynamic Portfolio Website**\r\n\r\n**Objective**: Build a comprehensive portfolio website that showcases your work and skills, integrating a variety of jQuery functionalities to enhance interactivity and performance. The site will feature an image gallery, interactive forms, an FAQ section, and AJAX-based content loading. This project will demonstrate the application of various jQuery concepts and techniques learned throughout the course.\r\n\r\n#### Overview\r\n\r\n1. **Introduction and Setup**\r\n   - **Project Goals**: To create a dynamic and interactive portfolio website using jQuery.\r\n   - **Project Structure**: Organize the project into different sections for easy management.\r\n   - **Tools and Libraries**: Use jQuery, jQuery UI, and relevant jQuery plugins.\r\n\r\n2. **Features to Implement**\r\n   - Image Gallery with lightbox effect.\r\n   - Interactive forms for contact and feedback.\r\n   - Collapsible FAQ section.\r\n   - Infinite scrolling for a blog or projects section.\r\n   - AJAX-based content loading for seamless updates.\r\n\r\n#### 1. **Project Setup**\r\n\r\n**1.1. Project Directory Structure**\r\n```plaintext\r\nportfolio-website/\r\n│\r\n├── index.html\r\n├── css/\r\n│   ├── styles.css\r\n│   └── jquery-ui.css\r\n├── js/\r\n│   ├── main.js\r\n│   └── jquery.min.js\r\n│   └── jquery-ui.min.js\r\n│   └── plugin.js (e.g., for image carousel)\r\n├── images/\r\n│   ├── gallery1.jpg\r\n│   ├── gallery2.jpg\r\n│   └── ...\r\n└── ajax/\r\n    └── projects.json\r\n```\r\n\r\n**1.2. Basic HTML Structure**\r\n\r\nCreate a basic HTML template with links to jQuery libraries and your custom scripts and styles.\r\n\r\n```html\r\n<!DOCTYPE html>\r\n<html lang="en">\r\n<head>\r\n    <meta charset="UTF-8">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\r\n    <title>Dynamic Portfolio</title>\r\n    <link rel="stylesheet" href="css/styles.css">\r\n    <link rel="stylesheet" href="css/jquery-ui.css">\r\n</head>\r\n<body>\r\n    <!-- Navigation -->\r\n    <nav>\r\n        <ul>\r\n            <li><a href="#gallery">Gallery</a></li>\r\n            <li><a href="#contact">Contact</a></li>\r\n            <li><a href="#faq">FAQ</a></li>\r\n            <li><a href="#projects">Projects</a></li>\r\n        </ul>\r\n    </nav>\r\n\r\n    <!-- Gallery Section -->\r\n    <section id="gallery">\r\n        <h2>Gallery</h2>\r\n        <div class="gallery-container">\r\n            <!-- Gallery Images -->\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Contact Form Section -->\r\n    <section id="contact">\r\n        <h2>Contact</h2>\r\n        <form id="contact-form">\r\n            <label for="name">Name:</label>\r\n            <input type="text" id="name" name="name" required>\r\n            <label for="email">Email:</label>\r\n            <input type="email" id="email" name="email" required>\r\n            <label for="message">Message:</label>\r\n            <textarea id="message" name="message" required></textarea>\r\n            <button type="submit">Send</button>\r\n        </form>\r\n    </section>\r\n\r\n    <!-- FAQ Section -->\r\n    <section id="faq">\r\n        <h2>FAQ</h2>\r\n        <div id="accordion">\r\n            <!-- FAQ Items -->\r\n        </div>\r\n    </section>\r\n\r\n    <!-- Projects Section with Infinite Scrolling -->\r\n    <section id="projects">\r\n        <h2>Projects</h2>\r\n        <div id="projects-container">\r\n            <!-- Projects will be loaded here -->\r\n        </div>\r\n        <div id="loading">Loading...</div>\r\n    </section>\r\n\r\n    <script src="js/jquery.min.js"></script>\r\n    <script src="js/jquery-ui.min.js"></script>\r\n    <script src="js/main.js"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n#### 2. **Image Gallery with Lightbox Effect**\r\n\r\n**2.1. Image Gallery Setup**\r\n\r\nUse jQuery to create an image gallery where clicking on a thumbnail opens a lightbox.\r\n\r\n**HTML:**\r\n```html\r\n<div class="gallery-container">\r\n    <a href="images/gallery1.jpg" class="gallery-item" data-lightbox="gallery">\r\n        <img src="images/gallery1.jpg" alt="Gallery Image 1">\r\n    </a>\r\n    <a href="images/gallery2.jpg" class="gallery-item" data-lightbox="gallery">\r\n        <img src="images/gallery2.jpg" alt="Gallery Image 2">\r\n    </a>\r\n    <!-- Add more images -->\r\n</div>\r\n```\r\n\r\n**CSS:**\r\n```css\r\n.gallery-container {\r\n    display: flex;\r\n    flex-wrap: wrap;\r\n}\r\n.gallery-item {\r\n    margin: 5px;\r\n}\r\n.gallery-item img {\r\n    width: 100px;\r\n    height: auto;\r\n    border: 2px solid #ddd;\r\n}\r\n```\r\n\r\n**JavaScript:**\r\nIntegrate a lightbox plugin (e.g., Lightbox2).\r\n\r\n```html\r\n<!-- Include Lightbox CSS and JS in HTML head -->\r\n<link href="path/to/lightbox.css" rel="stylesheet">\r\n<script src="path/to/lightbox-plus-jquery.js"></script>\r\n\r\n<script>\r\n  $(document).ready(function() {\r\n    lightbox.option({\r\n      'resizeDuration': 200,\r\n      'wrapAround': true\r\n    });\r\n  });\r\n</script>\r\n```\r\n\r\n#### 3. **Interactive Forms**\r\n\r\n**3.1. Contact Form Setup**\r\n\r\nAdd jQuery validation and handling to the contact form.\r\n\r\n**JavaScript:**\r\n```javascript\r\n$(document).ready(function() {\r\n  $("#contact-form").submit(function(event) {\r\n    event.preventDefault();\r\n    \r\n    // Form Validation\r\n    var isValid = true;\r\n    $("#contact-form input, #contact-form textarea").each(function() {\r\n      if ($(this).val() === '') {\r\n        isValid = false;\r\n        $(this).addClass('error');\r\n      } else {\r\n        $(this).removeClass('error');\r\n      }\r\n    });\r\n\r\n    if (isValid) {\r\n      // Form Submission (AJAX or other)\r\n      $.ajax({\r\n        url: 'send-mail.php',\r\n        type: 'POST',\r\n        data: $(this).serialize(),\r\n        success: function(response) {\r\n          alert('Message sent successfully!');\r\n          $("#contact-form")[0].reset();\r\n        },\r\n        error: function() {\r\n          alert('Failed to send message.');\r\n        }\r\n      });\r\n    } else {\r\n      alert('Please fill in all required fields.');\r\n    }\r\n  });\r\n});\r\n```\r\n\r\n**CSS for Validation:**\r\n```css\r\ninput.error, textarea.error {\r\n  border: 1px solid red;\r\n}\r\n```\r\n\r\n#### 4. **Collapsible FAQ Section**\r\n\r\n**4.1. FAQ Section Setup**\r\n\r\nCreate a collapsible FAQ section using jQuery UI Accordion.\r\n\r\n**HTML:**\r\n```html\r\n<div id="accordion">\r\n    <h3>What is your experience?</h3>\r\n    <div>\r\n        <p>Details about your experience...</p>\r\n    </div>\r\n    <h3>What technologies do you use?</h3>\r\n    <div>\r\n        <p>Details about the technologies you use...</p>\r\n    </div>\r\n    <!-- Add more FAQ items -->\r\n</div>\r\n```\r\n\r\n**JavaScript:**\r\n```javascript\r\n$(document).ready(function() {\r\n  $("#accordion").accordion({\r\n    heightStyle: "content"\r\n  });\r\n});\r\n```\r\n\r\n**CSS:**\r\n```css\r\n#accordion {\r\n    width: 80%;\r\n    margin: 0 auto;\r\n}\r\n```\r\n\r\n#### 5. **Infinite Scrolling for Projects Section**\r\n\r\n**5.1. Projects Section Setup**\r\n\r\nImplement infinite scrolling to load more projects as the user scrolls down.\r\n\r\n**JavaScript:**\r\n```javascript\r\n$(document).ready(function() {\r\n  var page = 1;\r\n  var loading = false;\r\n\r\n  function loadMoreProjects() {\r\n    if (loading) return;\r\n    loading = true;\r\n\r\n    $.ajax({\r\n      url: 'ajax/projects.json?page=' + page,\r\n      method: 'GET',\r\n      success: function(data) {\r\n        var $fragment = $(document.createDocumentFragment());\r\n\r\n        data.projects.forEach(function(project) {\r\n          var projectItem = $('<div class="project">')\r\n            .append('<h3>' + project.title + '</h3>')\r\n            .append('<p>' + project.description + '</p>');\r\n          $fragment.append(projectItem);\r\n        });\r\n\r\n        $('#projects-container').append($fragment);\r\n        page++;\r\n        loading = false;\r\n        if (data.projects.length === 0) {\r\n          $('#loading').hide(); // Hide loading message if no more projects\r\n        }\r\n      }\r\n    });\r\n  }\r\n\r\n  $(window).on('scroll', _.throttle(function() {\r\n    if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {\r\n      loadMoreProjects();\r\n    }\r\n  }, 200));\r\n\r\n  // Initial load\r\n  loadMoreProjects();\r\n});\r\n```\r\n\r\n**CSS:**\r\n```css\r\n.project {\r\n    padding: 20px;\r\n    border-bottom: 1px solid #ddd;\r\n}\r\n#loading {\r\n    text-align: center;\r\n    padding: 20px;\r\n}\r\n```\r\n\r\n**Note**: Use lodash or another library for throttling in the example above.\r\n\r\n#### 6. **Testing and Final Touches**\r\n\r\n**6.1. Cross-Browser Testing**\r\n\r\nEnsure that the website works across different browsers and devices. Test the functionality of the image gallery, forms, FAQ section, and infinite scrolling.\r\n\r\n**6.2. Performance Optimization**\r\n\r\n- Minify CSS and JavaScript files.\r\n- Optimize images for faster loading.\r\n- Use caching and content delivery networks (CDNs\r\n\r\n) where applicable.\r\n\r\n**6.3. Accessibility and SEO**\r\n\r\n- Add appropriate `alt` text for images.\r\n- Ensure that forms and interactive elements are accessible.\r\n- Use semantic HTML and meta tags for better SEO.\r\n\r\n---\r\n\r\n### Summary\r\n\r\nThis final mini project involves creating a fully functional portfolio website that integrates various jQuery concepts. By implementing an image gallery, interactive forms, a collapsible FAQ section, and infinite scrolling, you will apply your knowledge of jQuery to build a dynamic and engaging website.\r\n\r\n- **Image Gallery**: Utilize jQuery and lightbox plugins to create an interactive gallery.\r\n- **Interactive Forms**: Add real-time validation and AJAX submission for user interaction.\r\n- **FAQ Section**: Use jQuery UI to build a collapsible FAQ section.\r\n- **Infinite Scrolling**: Implement efficient content loading using AJAX and jQuery.\r\n\r\nThis project will not only demonstrate your ability to use jQuery effectively but also showcase your skills in creating a cohesive and user-friendly web experience.	2024-09-17 18:01:50.419843+00	final-mini-project-dynamic-portfolio-website	1
17	Introduction to JavaScript	JavaScript (JS) is a high-level, interpreted programming language that is widely used to create dynamic web content. It's one of the core technologies of the web, alongside HTML and CSS. Initially, it was designed for client-side operations, but with the introduction of frameworks like Node.js, it can also be used for server-side programming.\r\n\r\n## JavaScript Basics\r\n\r\n### 1. JavaScript Syntax\r\n\r\nJavaScript syntax refers to the set of rules that define a correctly structured JavaScript program. It includes keywords, operators, and punctuation that determine the logical flow of the code.\r\n\r\n#### Statements\r\nIn JavaScript, code is written as **statements**. A statement can perform an action or express logic. Typically, statements end with a **semicolon** (`;`), although semicolons are optional in many cases due to automatic semicolon insertion.\r\n\r\n```js\r\nlet x = 5;\r\nconsole.log(x); // Outputs: 5\r\n```\r\n\r\n#### Comments\r\nJavaScript allows you to add comments to improve the readability of your code.\r\n\r\n- **Single-line comments**: Begin with `//`\r\n  \r\n  ```js\r\n  // This is a single-line comment\r\n  ```\r\n\r\n- **Multi-line comments**: Enclosed within `/* */`\r\n  \r\n  ```js\r\n  /* This is a\r\n     multi-line comment */\r\n  ```\r\n\r\n#### Case Sensitivity\r\nJavaScript is **case-sensitive**. This means `myVariable` and `MyVariable` are treated as different variables.\r\n\r\n---\r\n\r\n### 2. Variables\r\n\r\nVariables store data values that can be used and manipulated throughout the program. In JavaScript, variables are declared using the keywords `var`, `let`, or `const`.\r\n\r\n#### Variable Declarations\r\n\r\n- **var**: The original way to declare variables. `var` has function-level scope, which can lead to unexpected behavior in certain cases.\r\n\r\n  ```js\r\n  var name = "John";\r\n  console.log(name); // Outputs: John\r\n  ```\r\n\r\n- **let**: Introduced in ES6 (ES2015), `let` provides block-level scope and is generally preferred over `var`.\r\n\r\n  ```js\r\n  let age = 25;\r\n  age = 26; // Can be reassigned\r\n  console.log(age); // Outputs: 26\r\n  ```\r\n\r\n- **const**: Also introduced in ES6, `const` creates variables that cannot be reassigned. It's used for values that should remain constant.\r\n\r\n  ```js\r\n  const pi = 3.14;\r\n  // pi = 3.14159; // This will throw an error\r\n  ```\r\n\r\n#### Variable Naming Rules\r\n- Must start with a letter, underscore (`_`), or dollar sign (`$`).\r\n- Cannot start with a number.\r\n- Names are case-sensitive (`myVar` is different from `myvar`).\r\n- Reserved keywords (like `class`, `return`, etc.) cannot be used as variable names.\r\n\r\n#### Data Types\r\n\r\nJavaScript is a **dynamically typed language**, meaning you don't have to specify the data type of a variable explicitly. Some of the basic data types include:\r\n\r\n- **Number**: Represents both integer and floating-point numbers.\r\n  ```js\r\n  let x = 5;\r\n  let y = 3.14;\r\n  ```\r\n\r\n- **String**: A sequence of characters enclosed in single or double quotes.\r\n  ```js\r\n  let greeting = "Hello, World!";\r\n  ```\r\n\r\n- **Boolean**: Represents logical values: `true` or `false`.\r\n  ```js\r\n  let isJavaScriptFun = true;\r\n  ```\r\n\r\n- **Null**: Represents an intentionally empty value.\r\n  ```js\r\n  let emptyValue = null;\r\n  ```\r\n\r\n- **Undefined**: A variable that has been declared but not assigned a value.\r\n  ```js\r\n  let notAssigned;\r\n  ```\r\n\r\n- **Object**: A collection of properties and values.\r\n  ```js\r\n  let person = {\r\n    firstName: "John",\r\n    lastName: "Doe"\r\n  };\r\n  ```\r\n\r\n- **Array**: A list of values.\r\n  ```js\r\n  let numbers = [1, 2, 3, 4, 5];\r\n  ```\r\n\r\n#### Type Conversion\r\nJavaScript automatically converts types when necessary (implicit type conversion), but you can also manually convert types (explicit type conversion).\r\n\r\n```js\r\nlet strNum = "10";\r\nlet num = Number(strNum); // Converts the string to a number\r\n```\r\n\r\n---\r\n\r\n### 3. Control Structures\r\n\r\nControl structures in JavaScript dictate the flow of execution based on certain conditions or loops.\r\n\r\n#### 3.1 Conditional Statements\r\n\r\nConditional statements control the execution of code blocks based on conditions.\r\n\r\n##### if Statement\r\nExecutes a block of code if the specified condition is `true`.\r\n\r\n```js\r\nif (condition) {\r\n  // Code to be executed if the condition is true\r\n}\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nlet age = 18;\r\n\r\nif (age >= 18) {\r\n  console.log("You are an adult.");\r\n}\r\n```\r\n\r\n##### if...else Statement\r\nProvides an alternative block of code to execute when the condition is `false`.\r\n\r\n```js\r\nif (condition) {\r\n  // Code to be executed if the condition is true\r\n} else {\r\n  // Code to be executed if the condition is false\r\n}\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nlet age = 16;\r\n\r\nif (age >= 18) {\r\n  console.log("You are an adult.");\r\n} else {\r\n  console.log("You are a minor.");\r\n}\r\n```\r\n\r\n##### if...else if...else Statement\r\nAllows for multiple conditions to be tested in sequence.\r\n\r\n```js\r\nif (condition1) {\r\n  // Code to be executed if condition1 is true\r\n} else if (condition2) {\r\n  // Code to be executed if condition1 is false and condition2 is true\r\n} else {\r\n  // Code to be executed if all conditions are false\r\n}\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nlet score = 85;\r\n\r\nif (score >= 90) {\r\n  console.log("A grade");\r\n} else if (score >= 80) {\r\n  console.log("B grade");\r\n} else {\r\n  console.log("C grade");\r\n}\r\n```\r\n\r\n##### Switch Statement\r\nUsed to perform different actions based on different conditions.\r\n\r\n```js\r\nswitch (expression) {\r\n  case value1:\r\n    // Code to execute if expression matches value1\r\n    break;\r\n  case value2:\r\n    // Code to execute if expression matches value2\r\n    break;\r\n  default:\r\n    // Code to execute if no case matches\r\n}\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nlet fruit = "apple";\r\n\r\nswitch (fruit) {\r\n  case "banana":\r\n    console.log("Banana is yellow.");\r\n    break;\r\n  case "apple":\r\n    console.log("Apple is red.");\r\n    break;\r\n  default:\r\n    console.log("Unknown fruit.");\r\n}\r\n```\r\n\r\n---\r\n\r\n#### 3.2 Loops\r\n\r\nLoops in JavaScript are used to repeatedly execute a block of code.\r\n\r\n##### for Loop\r\nThe `for` loop is used to repeat a block of code a specific number of times.\r\n\r\n```js\r\nfor (initialization; condition; increment) {\r\n  // Code to execute on each iteration\r\n}\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nfor (let i = 0; i < 5; i++) {\r\n  console.log(i); // Outputs 0, 1, 2, 3, 4\r\n}\r\n```\r\n\r\n##### while Loop\r\nThe `while` loop is used when the number of iterations is unknown, and the loop runs as long as a condition is `true`.\r\n\r\n```js\r\nwhile (condition) {\r\n  // Code to execute while the condition is true\r\n}\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nlet i = 0;\r\n\r\nwhile (i < 5) {\r\n  console.log(i); // Outputs 0, 1, 2, 3, 4\r\n  i++;\r\n}\r\n```\r\n\r\n##### do...while Loop\r\nThe `do...while` loop is similar to the `while` loop, but it ensures that the code block is executed at least once.\r\n\r\n```js\r\ndo {\r\n  // Code to execute\r\n} while (condition);\r\n```\r\n\r\nExample:\r\n\r\n```js\r\nlet i = 0;\r\n\r\ndo {\r\n  console.log(i); // Outputs 0, 1, 2, 3, 4\r\n  i++;\r\n} while (i < 5);\r\n```\r\n\r\n---\r\n\r\n### Conclusion\r\n\r\nJavaScript's syntax, variables, and control structures form the core building blocks of the language. With these fundamentals, you can perform basic operations and control the flow of your program. As you advance, you'll delve into functions, objects, events, and more complex data manipulation.	2024-09-18 16:26:57.562343+00	introduction-to-javascript	2
18	Operators in Javascript	### 1. **Arithmetic Operators**\r\nUsed for mathematical operations.\r\n\r\n| Operator | Description            | Example                       | Result |\r\n|----------|------------------------|-------------------------------|--------|\r\n| `+`      | Addition                | `5 + 3`                       | `8`    |\r\n| `-`      | Subtraction             | `5 - 3`                       | `2`    |\r\n| `*`      | Multiplication          | `5 * 3`                       | `15`   |\r\n| `/`      | Division                | `5 / 2`                       | `2.5`  |\r\n| `%`      | Modulus (remainder)     | `5 % 2`                       | `1`    |\r\n| `++`     | Increment               | `let x = 5; x++`              | `6`    |\r\n| `--`     | Decrement               | `let x = 5; x--`              | `4`    |\r\n\r\n### Example:\r\n```javascript\r\nlet a = 10;\r\nlet b = 3;\r\nconsole.log(a + b); // Output: 13\r\nconsole.log(a - b); // Output: 7\r\nconsole.log(a * b); // Output: 30\r\nconsole.log(a / b); // Output: 3.3333\r\nconsole.log(a % b); // Output: 1\r\n```\r\n\r\n### 2. **Assignment Operators**\r\nUsed to assign values to variables.\r\n\r\n| Operator | Description                | Example          | Result         |\r\n|----------|----------------------------|------------------|----------------|\r\n| `=`      | Assigns value               | `x = 5`          | `x = 5`        |\r\n| `+=`     | Adds and assigns            | `x += 5`         | `x = x + 5`    |\r\n| `-=`     | Subtracts and assigns       | `x -= 5`         | `x = x - 5`    |\r\n| `*=`     | Multiplies and assigns      | `x *= 5`         | `x = x * 5`    |\r\n| `/=`     | Divides and assigns         | `x /= 5`         | `x = x / 5`    |\r\n| `%=`     | Modulus and assigns         | `x %= 5`         | `x = x % 5`    |\r\n\r\n### Example:\r\n```javascript\r\nlet a = 10;\r\na += 5;  // Now a = 15\r\nconsole.log(a); // Output: 15\r\na *= 2;  // Now a = 30\r\nconsole.log(a); // Output: 30\r\n```\r\n\r\n### 3. **Comparison Operators**\r\nUsed to compare two values, returning a boolean (`true` or `false`).\r\n\r\n| Operator | Description                        | Example         | Result  |\r\n|----------|------------------------------------|-----------------|---------|\r\n| `==`     | Equal to (value)                   | `5 == '5'`      | `true`  |\r\n| `===`    | Strict equal to (value & type)      | `5 === '5'`     | `false` |\r\n| `!=`     | Not equal to (value)               | `5 != '5'`      | `false` |\r\n| `!==`    | Strict not equal to (value & type)  | `5 !== '5'`     | `true`  |\r\n| `>`      | Greater than                       | `5 > 3`         | `true`  |\r\n| `<`      | Less than                          | `5 < 3`         | `false` |\r\n| `>=`     | Greater than or equal to           | `5 >= 3`        | `true`  |\r\n| `<=`     | Less than or equal to              | `5 <= 5`        | `true`  |\r\n\r\n### Example:\r\n```javascript\r\nconsole.log(10 == '10'); // true (value is equal)\r\nconsole.log(10 === '10'); // false (strict comparison)\r\nconsole.log(10 > 5); // true\r\nconsole.log(10 !== '10'); // true (value matches but type does not)\r\n```\r\n\r\n### 4. **Logical Operators**\r\nUsed to perform logical operations between values or expressions.\r\n\r\n| Operator | Description                | Example               | Result |\r\n|----------|----------------------------|-----------------------|--------|\r\n| `&&`     | Logical AND                 | `true && false`       | `false`|\r\n| `||`     | Logical OR                  | `true || false`       | `true` |\r\n| `!`      | Logical NOT                 | `!true`               | `false`|\r\n\r\n### Example:\r\n```javascript\r\nlet a = 10, b = 5;\r\nconsole.log(a > 5 && b < 10); // true\r\nconsole.log(a > 15 || b < 10); // true\r\nconsole.log(!(a > 5)); // false\r\n```\r\n\r\n### 5. **Bitwise Operators**\r\nUsed to perform bit-level operations.\r\n\r\n| Operator | Description                | Example        | Result |\r\n|----------|----------------------------|----------------|--------|\r\n| `&`      | AND                        | `5 & 1`        | `1`    |\r\n| `|`      | OR                         | `5 | 1`        | `5`    |\r\n| `^`      | XOR                        | `5 ^ 1`        | `4`    |\r\n| `~`      | NOT                        | `~5`           | `-6`   |\r\n| `<<`     | Left shift                 | `5 << 1`       | `10`   |\r\n| `>>`     | Right shift                | `5 >> 1`       | `2`    |\r\n\r\n### Example:\r\n```javascript\r\nconsole.log(5 & 1);  // Output: 1\r\nconsole.log(5 | 1);  // Output: 5\r\nconsole.log(5 ^ 1);  // Output: 4\r\nconsole.log(~5);     // Output: -6\r\nconsole.log(5 << 1); // Output: 10\r\nconsole.log(5 >> 1); // Output: 2\r\n```\r\n\r\n### 6. **Ternary (Conditional) Operator**\r\nThis is a shortcut for an `if-else` statement.\r\n\r\n| Operator | Description                          | Example               | Result |\r\n|----------|--------------------------------------|-----------------------|--------|\r\n| `? :`    | Conditional expression (ternary)     | `x > 5 ? 'Yes' : 'No'`| `Yes`  |\r\n\r\n### Example:\r\n```javascript\r\nlet age = 18;\r\nlet canVote = (age >= 18) ? "Yes" : "No";\r\nconsole.log(canVote); // Output: Yes\r\n```\r\n\r\n### 7. **Type Operators**\r\nUsed to check or manipulate the type of variables.\r\n\r\n| Operator | Description                     | Example               | Result           |\r\n|----------|---------------------------------|-----------------------|------------------|\r\n| `typeof` | Returns the type of a variable   | `typeof 'hello'`      | `"string"`       |\r\n| `instanceof` | Checks if an object is an instance of a class | `obj instanceof Array` | `true` (if obj is an array) |\r\n\r\n### Example:\r\n```javascript\r\nconsole.log(typeof 42);         // Output: "number"\r\nconsole.log(typeof 'hello');    // Output: "string"\r\nconsole.log([1, 2, 3] instanceof Array); // true\r\n```\r\n\r\n### 8. **Spread and Rest Operators**\r\n- **Spread (`...`)**: Expands an array or object into individual elements.\r\n- **Rest (`...`)**: Collects arguments into an array.\r\n\r\n### Example:\r\n```javascript\r\nlet arr = [1, 2, 3];\r\nlet newArr = [...arr, 4, 5];  // Spread\r\nconsole.log(newArr);  // Output: [1, 2, 3, 4, 5]\r\n\r\nfunction sum(...args) {  // Rest\r\n    return args.reduce((total, current) => total + current, 0);\r\n}\r\nconsole.log(sum(1, 2, 3));  // Output: 6\r\n```\r\n\r\n### 9. **Comma Operator**\r\nUsed to evaluate multiple expressions in a single statement, returning the result of the last expression.\r\n\r\n### Example:\r\n```javascript\r\nlet x = (2 + 3, 5 + 1); // First evaluates 2 + 3, then 5 + 1\r\nconsole.log(x); // Output: 6\r\n```\r\n\r\n### 10. **Nullish Coalescing Operator (`??`)**\r\nReturns the right-hand operand if the left-hand operand is `null` or `undefined`.\r\n\r\n### Example:\r\n```javascript\r\nlet name = null;\r\nlet defaultName = name ?? "Guest";\r\nconsole.log(defaultName); // Output: "Guest"\r\n```	2024-09-18 18:16:15.511967+00	operators-in-javascript	2
\.


--
-- Data for Name: main_note_topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_note_topics (id, note_id, topic_id) FROM stdin;
1	1	151
2	2	151
3	3	172
4	4	71
5	5	264
6	6	264
7	7	264
8	8	264
9	9	264
10	10	264
12	12	265
13	13	265
14	11	265
15	14	265
16	15	265
17	16	265
18	17	260
19	18	260
\.


--
-- Data for Name: main_question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_question (id, content, created_at, auto_slug, added_by_id, title) FROM stdin;
2	### NumPy and Pandas Questions\r\n\r\n#### **NumPy Questions**\r\n\r\n1. **What is NumPy and why is it used in Python?**\r\n2. **How do you install the NumPy library? Provide the command.**\r\n3. **What is a NumPy array? How does it differ from a Python list?**\r\n4. **How do you create a NumPy array from a Python list?**\r\n5. **How can you create an array filled with zeros or ones in NumPy?**\r\n6. **Explain the difference between `np.zeros()` and `np.empty()`.**\r\n7. **How do you create a 2D array in NumPy? Provide an example.**\r\n8. **What does the `shape` attribute of a NumPy array represent?**\r\n9. **How can you find the number of dimensions of an array in NumPy?**\r\n10. **What is array slicing in NumPy? How is it performed?**\r\n11. **How do you perform element-wise addition and subtraction in NumPy?**\r\n12. **Explain how broadcasting works in NumPy. Provide an example.**\r\n13. **What is the purpose of the `reshape()` method in NumPy?**\r\n14. **How do you find the maximum and minimum values in a NumPy array?**\r\n15. **What is the difference between `np.sum()` and `np.cumsum()`?**\r\n16. **How do you calculate the mean, median, and standard deviation of a NumPy array?**\r\n17. **Explain the use of the `arange()` function in NumPy.**\r\n18. **What is the difference between `linspace()` and `arange()` in NumPy?**\r\n19. **How can you sort a NumPy array?**\r\n20. **Explain how to filter elements from a NumPy array using Boolean indexing.**\r\n21. **What is the purpose of `np.dot()`? How is it different from the `*` operator?**\r\n22. **How do you generate random numbers using NumPy?**\r\n23. **What are the benefits of using vectorized operations in NumPy?**\r\n24. **How can you stack two NumPy arrays vertically and horizontally?**\r\n25. **Explain the concept of NumPy views. How is it different from a copy?**\r\n\r\n#### **Pandas Questions**\r\n\r\n26. **What is Pandas, and why is it important for data analysis?**\r\n27. **How do you install the Pandas library? Provide the command.**\r\n28. **What are the main data structures in Pandas?**\r\n29. **How do you create a DataFrame from a dictionary in Pandas?**\r\n30. **Explain the difference between a DataFrame and a Series in Pandas.**\r\n31. **How do you read a CSV file into a Pandas DataFrame?**\r\n32. **How can you display the first 5 rows of a DataFrame?**\r\n33. **What does the `info()` method do in a Pandas DataFrame?**\r\n34. **How can you select a single column from a DataFrame?**\r\n35. **Explain how to select multiple columns in a DataFrame.**\r\n36. **How do you filter rows in a DataFrame based on a condition?**\r\n37. **What is the purpose of the `loc[]` and `iloc[]` indexers in Pandas?**\r\n38. **How do you add a new column to an existing DataFrame?**\r\n39. **Explain how to delete a column from a DataFrame.**\r\n40. **How can you handle missing data in a DataFrame?**\r\n41. **What is the difference between `dropna()` and `fillna()` in Pandas?**\r\n42. **How do you group data in a DataFrame by one or more columns?**\r\n43. **Explain how to merge two DataFrames in Pandas.**\r\n44. **What is the purpose of the `concat()` function in Pandas?**\r\n45. **How do you apply a function to each element of a DataFrame column?**\r\n46. **Explain how to sort a DataFrame by one or more columns.**\r\n47. **How do you reset the index of a DataFrame?**\r\n48. **What is the purpose of the `pivot_table()` method in Pandas?**\r\n49. **How do you visualize data from a Pandas DataFrame using Matplotlib?**\r\n50. **Explain the concept of a rolling window in Pandas. How is it used?**	2024-09-03 18:15:01.512784+00	question-set-1	1	Question Set 1
3	# 🧩 jQuery Practical Questions\r\n\r\n## 🖋️ DOM Manipulation\r\n\r\n1. **Add a New Element**\r\n   - Given a `<div id="container"></div>` in your HTML, write jQuery code to append a new `<p>` element with the text "Hello World!" to this `<div>`.\r\n\r\n2. **Change Element Text**\r\n   - Write jQuery code to change the text of an element with the class `.header` to "Welcome to My Site".\r\n\r\n3. **Remove Elements**\r\n   - Given a list `<ul id="myList"><li>Item 1</li><li>Item 2</li><li>Item 3</li></ul>`, write jQuery code to remove the second item from the list.\r\n\r\n4. **Add Class to Elements**\r\n   - Write jQuery code to add a class `highlight` to all `<p>` elements on the page.\r\n\r\n5. **Toggle Visibility**\r\n   - Given a `<div id="toggleDiv"></div>`, write jQuery code to toggle its visibility when a button with the id `#toggleButton` is clicked.\r\n\r\n## 🎯 Event Handling\r\n\r\n6. **Event Handling on Click**\r\n   - Write jQuery code to show an alert with the message "Button clicked!" when a button with the id `#alertButton` is clicked.\r\n\r\n7. **Change Input Value**\r\n   - Write jQuery code to change the value of an `<input>` field with the id `#textInput` to "New Value" when a button with the id `#changeValueButton` is clicked.\r\n\r\n8. **Hover Effect**\r\n   - Write jQuery code to change the background color of an element with the class `.hoverable` to yellow when the mouse hovers over it, and revert to the original color when the mouse leaves.\r\n\r\n9. **Form Submission**\r\n   - Given a form with the id `#myForm`, write jQuery code to prevent the default form submission and display an alert with the message "Form submitted!" when the form is submitted.\r\n\r\n10. **Event Delegation**\r\n    - Write jQuery code to handle clicks on dynamically added `<button>` elements with the class `.dynamicButton` inside a `<div id="buttonContainer">`. Display an alert with the button’s text when clicked.\r\n\r\n## 🎨 Animations\r\n\r\n11. **Fade In/Out**\r\n    - Write jQuery code to fade in an element with the id `#fadeElement` over 2 seconds when a button with the id `#fadeInButton` is clicked, and fade it out when a button with the id `#fadeOutButton` is clicked.\r\n\r\n12. **Slide Toggle**\r\n    - Write jQuery code to slide toggle a `<div id="slideDiv"></div>` when a button with the id `#slideToggleButton` is clicked.\r\n\r\n13. **Animate CSS Properties**\r\n    - Write jQuery code to animate the width of an element with the id `#animateDiv` from 100px to 500px over 1 second when a button with the id `#animateButton` is clicked.\r\n\r\n14. **Custom Animation**\r\n    - Write jQuery code to create a custom animation that changes the height of an element with the id `#customAnimate` to 200px over 3 seconds, then changes it back to 100px.\r\n\r\n15. **Queue Animation**\r\n    - Write jQuery code to queue multiple animations for an element with the id `#queueElement`, such as fading out, then sliding up, then sliding down, all in sequence when a button with the id `#queueButton` is clicked.\r\n\r\n## 🔍 Effects\r\n\r\n16. **Toggle Class**\r\n    - Write jQuery code to toggle a class `active` on an element with the id `#effectElement` when a button with the id `#toggleClassButton` is clicked.\r\n\r\n17. **Hide/Show Elements**\r\n    - Write jQuery code to hide all elements with the class `.hideable` and show them again when a button with the id `#showButton` is clicked.\r\n\r\n18. **Animate Height**\r\n    - Write jQuery code to animate the height of a `<div>` with the id `#animateHeight` from 50px to 150px when a button with the id `#heightButton` is clicked.\r\n\r\n19. **Add Fade Effect to Images**\r\n    - Given a set of images inside a container with the id `#imageContainer`, write jQuery code to add a fade effect to each image when the container is hovered over.\r\n\r\n20. **Fade to Specific Color**\r\n    - Write jQuery code to fade an element with the id `#colorFade` to a specific background color (e.g., `#ff0000`) over 2 seconds when a button with the id `#colorFadeButton` is clicked.	2024-09-10 21:25:59.233045+00	question-set-2	2	Question Set 2
\.


--
-- Data for Name: main_question_topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_question_topics (id, question_id, topic_id) FROM stdin;
2	2	71
3	3	264
\.


--
-- Data for Name: main_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_subject (id, name, description, auto_slug) FROM stdin;
3	Data Science	An all-encompassing guide to data science, from fundamentals to advanced applications.	data-science
5	MERN Stack	A complete guide to mastering full-stack development using the MERN stack.	mern-stack
6	Django Web Development	A complete guide to mastering web development using the Django framework.	django-web-development
7	PHP Web Development	A complete guide to mastering web development using PHP.	php-web-development
8	Python Programming	A complete guide to mastering Python programming, from the basics to advanced applications.	python-programming
9	Web Design	An in-depth guide to mastering web design from fundamentals to advanced techniques.	web-design
\.


--
-- Data for Name: main_topic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_topic (id, name, description, auto_slug, subject_id) FROM stdin;
121	Introduction to MERN Stack	Overview of the MERN stack and its components.	introduction-to-mern-stack	5
122	JavaScript Essentials	Advanced JavaScript concepts, ES6+, and best practices.	javascript-essentials	5
123	Node.js Fundamentals	Understanding Node.js, npm, and asynchronous programming.	nodejs-fundamentals	5
124	Building RESTful APIs with Express.js	Introduction to Express.js, routing, and middleware.	building-restful-apis-with-expressjs	5
125	Advanced Express Techniques	Error handling, JWT authentication, and security practices.	advanced-express-techniques	5
126	Database Fundamentals with MongoDB	CRUD operations, indexing, and schema design in MongoDB.	database-fundamentals-with-mongodb	5
127	Advanced MongoDB	Aggregation framework, transactions, and replication.	advanced-mongodb	5
128	Connecting Express with MongoDB	Using Mongoose for data modeling and validation.	connecting-express-with-mongodb	5
129	React Fundamentals	Introduction to React, components, and JSX.	react-fundamentals	5
130	React Hooks and State Management	Understanding hooks, context API, and state management.	react-hooks-and-state-management	5
131	Advanced React Patterns	Higher-order components, render props, and custom hooks.	advanced-react-patterns	5
132	Routing in React with React Router	Implementing client-side routing with React Router.	routing-in-react-with-react-router	5
133	Styling React Applications	CSS-in-JS, styled-components, and Tailwind CSS.	styling-react-applications	5
134	State Management with Redux	Using Redux for global state management and side effects.	state-management-with-redux	5
135	Integrating React with Backend APIs	Fetching data from APIs and managing asynchronous calls.	integrating-react-with-backend-apis	5
136	Authentication in MERN	User authentication with JWT, OAuth, and sessions.	authentication-in-mern	5
137	File Uploads and Storage	Handling file uploads with Multer and cloud storage.	file-uploads-and-storage	5
138	Testing MERN Applications	Unit, integration, and end-to-end testing with Jest and Mocha.	testing-mern-applications	5
139	Advanced Node.js and Express Techniques	Clustering, scaling, and performance optimization.	advanced-nodejs-and-express-techniques	5
140	Real-time Communication with Socket.io	Implementing WebSockets for real-time applications.	real-time-communication-with-socketio	5
141	GraphQL with MERN	Introduction to GraphQL and integrating with MERN stack.	graphql-with-mern	5
68	Introduction to Data Science	Overview, importance, and lifecycle of data science projects.	introduction-to-data-science	3
69	Programming for Data Science	Python programming essentials for data science.	programming-for-data-science	3
70	Mathematics for Data Science	Key math concepts: linear algebra, statistics, and calculus.	mathematics-for-data-science	3
71	Data Analysis and Manipulation	Data wrangling, cleaning, and exploration with Python.	data-analysis-and-manipulation	3
72	Exploratory Data Analysis (EDA) and Visualization	Fundamentals of data visualization and descriptive statistics.	exploratory-data-analysis-eda-and-visualization	3
73	Introduction to Machine Learning	Basics of machine learning, types, and algorithms.	introduction-to-machine-learning	3
74	Supervised Learning Techniques	In-depth study of supervised learning methods.	supervised-learning-techniques	3
75	Unsupervised Learning Techniques	Overview of clustering and dimensionality reduction.	unsupervised-learning-techniques	3
76	Advanced Machine Learning Techniques	Ensemble learning, model optimization, and regularization.	advanced-machine-learning-techniques	3
77	Introduction to Deep Learning	Basics of neural networks and deep learning frameworks.	introduction-to-deep-learning	3
78	Specialized Deep Learning Models	Advanced models: CNNs, RNNs, and GANs.	specialized-deep-learning-models	3
79	Natural Language Processing (NLP)	Text processing and NLP techniques.	natural-language-processing-nlp	3
80	Time Series Analysis	Analysis and forecasting of time series data.	time-series-analysis	3
81	Data Engineering Fundamentals	Data management, ETL processes, and big data tools.	data-engineering-fundamentals	3
82	Model Deployment and Maintenance	Deploy models using Flask, Docker, and cloud platforms.	model-deployment-and-maintenance	3
83	Ethics and Fairness in Data Science	Ethical considerations, bias, and fairness in AI.	ethics-and-fairness-in-data-science	3
84	Practical Data Science Projects	Hands-on projects and real-world case studies.	practical-data-science-projects	3
85	Data Privacy and Security	Protecting data and ensuring privacy.	data-privacy-and-security	3
86	Feature Engineering	Techniques for creating effective features.	feature-engineering	3
87	Introduction to Cloud Computing	Using cloud services for data science.	introduction-to-cloud-computing	3
88	Big Data Analytics	Analysis of large-scale data using Hadoop and Spark.	big-data-analytics	3
89	Data Science Tools and Platforms	Overview of tools like Jupyter, RStudio, and Apache Spark.	data-science-tools-and-platforms	3
142	Deployment and DevOps for MERN	Deploying MERN applications using Docker, AWS, and CI/CD pipelines.	deployment-and-devops-for-mern	5
143	Server-side Rendering with Next.js	Using Next.js for server-side rendering in React applications.	server-side-rendering-with-nextjs	5
144	Caching and Performance Optimization	Implementing caching strategies with Redis and optimizing performance.	caching-and-performance-optimization	5
145	Microservices Architecture with MERN	Building and deploying microservices using Node.js and Docker.	microservices-architecture-with-mern	5
146	Handling Payments	Integrating payment gateways like Stripe and PayPal.	handling-payments	5
147	Advanced Security Practices	Implementing advanced security measures like CSRF, XSS, and encryption.	advanced-security-practices	5
148	Scalable Application Design	Designing scalable and maintainable applications with MERN.	scalable-application-design	5
149	Building RESTful APIs with GraphQL	Combining REST and GraphQL for flexible APIs.	building-restful-apis-with-graphql	5
150	Real-world MERN Projects	Developing capstone projects and real-world applications.	real-world-mern-projects	5
151	Introduction to Django	Overview of Django, its features, and the MVC architecture.	introduction-to-django	6
152	Setting Up the Django Environment	Installing Django, setting up a virtual environment, and creating a project.	setting-up-the-django-environment	6
153	Django Project Structure	Understanding Django's project structure, apps, and their components.	django-project-structure	6
154	Django Models and ORM	Creating models, using Django ORM for database operations, and migrations.	django-models-and-orm	6
155	Django Views and Templates	Function-based views (FBV), class-based views (CBV), and using templates for dynamic content.	django-views-and-templates	6
156	Django Forms and Validations	Creating forms, handling form submissions, and performing validations.	django-forms-and-validations	6
157	Django URL Routing	Defining URL patterns and linking views to URLs.	django-url-routing	6
158	Django Admin Interface	Customizing the Django admin panel and managing models.	django-admin-interface	6
159	Static and Media Files in Django	Serving static and media files in a Django project.	static-and-media-files-in-django	6
160	User Authentication in Django	Implementing user authentication, login, logout, and registration.	user-authentication-in-django	6
161	Django Middleware	Understanding middleware and creating custom middleware.	django-middleware	6
162	Advanced Django ORM Techniques	Query optimization, aggregation, and using raw SQL queries.	advanced-django-orm-techniques	6
163	Django Security Best Practices	Implementing security measures like CSRF, XSS, and SQL injection prevention.	django-security-best-practices	6
164	File Uploads and Management	Handling file uploads and management in Django.	file-uploads-and-management	6
165	Django REST Framework (DRF)	Building RESTful APIs using Django REST Framework.	django-rest-framework-drf	6
166	Testing in Django	Writing unit tests, integration tests, and using Django's testing tools.	testing-in-django	6
167	Internationalization and Localization	Translating a Django app to multiple languages.	internationalization-and-localization	6
168	Django Signals	Using signals for decoupled event handling in Django.	django-signals	6
169	Caching in Django	Implementing caching strategies to optimize performance.	caching-in-django	6
170	Integrating Frontend Frameworks	Combining Django with frontend frameworks like React or Vue.js.	integrating-frontend-frameworks	6
171	GraphQL with Django	Building GraphQL APIs with Django and Graphene.	graphql-with-django	6
172	Real-time Features with Django Channels	Adding real-time capabilities with WebSockets using Django Channels.	real-time-features-with-django-channels	6
173	Django Deployment	Deploying Django applications using Gunicorn, Nginx, and Docker.	django-deployment	6
174	Continuous Integration/Continuous Deployment (CI/CD)	Automating deployment with tools like Jenkins, Travis CI, and GitHub Actions.	continuous-integrationcontinuous-deployment-cicd	6
175	Django Asynchronous Views	Implementing asynchronous views and optimizing performance.	django-asynchronous-views	6
176	Scaling Django Applications	Scaling applications horizontally and vertically.	scaling-django-applications	6
177	Custom Django Commands	Creating custom management commands for Django applications.	custom-django-commands	6
178	WebSockets in Django	Implementing WebSockets for real-time data communication.	websockets-in-django	6
179	Dockerizing Django Projects	Containerizing Django applications with Docker.	dockerizing-django-projects	6
180	Advanced Django Settings Management	Managing settings for different environments and secrets management.	advanced-django-settings-management	6
181	Building a SaaS Application with Django	Designing and developing a SaaS platform using Django.	building-a-saas-application-with-django	6
182	Practical Django Projects	Building real-world applications like eCommerce, blogs, and social networks.	practical-django-projects	6
183	Introduction to PHP	Basics of PHP, its syntax, and setup.	introduction-to-php	7
184	PHP Environment Setup	Installing PHP, setting up a local development environment using XAMPP, WAMP, or MAMP.	php-environment-setup	7
185	PHP Syntax and Basics	Variables, data types, operators, and control structures.	php-syntax-and-basics	7
186	PHP Functions	Defining and using functions, scope, and variable functions.	php-functions	7
187	PHP Arrays	Working with indexed, associative, and multidimensional arrays.	php-arrays	7
188	PHP Strings	String manipulation, concatenation, and functions.	php-strings	7
189	Form Handling with PHP	Handling GET and POST requests, form validation, and sanitization.	form-handling-with-php	7
190	PHP Sessions and Cookies	Creating and managing sessions and cookies for user data.	php-sessions-and-cookies	7
191	PHP File Handling	Reading, writing, and managing files with PHP.	php-file-handling	7
192	PHP Object-Oriented Programming (OOP)	Classes, objects, inheritance, polymorphism, and encapsulation.	php-object-oriented-programming-oop	7
193	PHP Error and Exception Handling	Handling errors and exceptions using try-catch blocks.	php-error-and-exception-handling	7
194	PHP Regular Expressions	Using regular expressions for pattern matching and validation.	php-regular-expressions	7
195	PHP and MySQL Integration	Connecting to a MySQL database, CRUD operations, and prepared statements.	php-and-mysql-integration	7
196	Advanced Database Operations	Transactions, indexing, joins, and optimizing queries.	advanced-database-operations	7
197	PHP Frameworks Overview	Introduction to popular PHP frameworks like Laravel, Symfony, and CodeIgniter.	php-frameworks-overview	7
198	Building Web Applications with Laravel	MVC architecture, routing, blade templates, and Eloquent ORM.	building-web-applications-with-laravel	7
199	RESTful API Development with PHP	Creating REST APIs, handling requests, and using JSON.	restful-api-development-with-php	7
200	PHP Security Best Practices	Preventing SQL injection, XSS, CSRF, and securing user data.	php-security-best-practices	7
201	PHP Unit Testing	Writing unit tests using PHPUnit for code quality assurance.	php-unit-testing	7
202	PHP Mail Handling	Sending emails with PHP, using libraries like PHPMailer.	php-mail-handling	7
203	Working with Composer	Managing PHP dependencies with Composer.	working-with-composer	7
204	PHP Design Patterns	Implementing common design patterns like Singleton, Factory, and Observer.	php-design-patterns	7
205	Integrating PHP with Frontend	Using PHP with HTML, CSS, JavaScript, and AJAX for dynamic content.	integrating-php-with-frontend	7
206	Caching Techniques in PHP	Implementing caching strategies using Memcached or Redis.	caching-techniques-in-php	7
207	PHP for Real-time Applications	Building real-time apps with WebSockets and PHP.	php-for-real-time-applications	7
208	Deploying PHP Applications	Deploying PHP applications on various hosting environments.	deploying-php-applications	7
209	Microservices with PHP	Building and managing microservices architecture with PHP.	microservices-with-php	7
210	PHP and Cloud Platforms	Integrating PHP applications with cloud services like AWS, GCP, or Azure.	php-and-cloud-platforms	7
211	GraphQL with PHP	Creating and managing GraphQL APIs using PHP.	graphql-with-php	7
212	Advanced PHP Features	Using namespaces, traits, and generators for more robust applications.	advanced-php-features	7
213	Building a CMS with PHP	Developing a Content Management System from scratch.	building-a-cms-with-php	7
214	Optimizing PHP Applications	Performance optimization techniques, including code profiling and caching.	optimizing-php-applications	7
215	Practical PHP Projects	Hands-on experience through building real-world projects like eCommerce sites, blogs, and REST APIs.	practical-php-projects	7
216	Introduction to Python	Overview, history, and applications of Python.	introduction-to-python	8
217	Python Installation and Setup	Setting up Python environment, IDEs, and virtual environments.	python-installation-and-setup	8
218	Basic Syntax and Data Types	Understanding Python syntax, variables, data types, and type conversion.	basic-syntax-and-data-types	8
219	Control Structures	Conditional statements, loops, and iteration.	control-structures	8
220	Functions and Modules	Defining functions, scope, lambda expressions, and creating modules.	functions-and-modules	8
221	Data Structures in Python	Lists, tuples, sets, dictionaries, and their operations.	data-structures-in-python	8
222	String Manipulation	String operations, formatting, and regular expressions.	string-manipulation	8
223	File Handling	Reading, writing, and manipulating files.	file-handling	8
224	Error and Exception Handling	Using try-except blocks, handling errors, and raising exceptions.	error-and-exception-handling	8
225	Object-Oriented Programming (OOP)	Classes, objects, inheritance, polymorphism, encapsulation.	object-oriented-programming-oop	8
226	Advanced OOP Concepts	Magic methods, decorators, context managers, and metaclasses.	advanced-oop-concepts	8
227	Working with Libraries and Packages	Installing and using libraries like NumPy, pandas, requests.	working-with-libraries-and-packages	8
228	Data Analysis with Python	Data analysis using pandas, NumPy, and data visualization with Matplotlib and Seaborn.	data-analysis-with-python	8
229	Web Development with Flask	Introduction to Flask, routing, templates, and building APIs.	web-development-with-flask	8
230	Web Development with Django	Building web applications using Django, models, views, templates.	web-development-with-django	8
231	Automating Tasks with Python	Using libraries like Selenium, BeautifulSoup, and requests for automation.	automating-tasks-with-python	8
232	Python for Data Science	Introduction to data science concepts, EDA, and machine learning with scikit-learn.	python-for-data-science	8
233	Introduction to Machine Learning	Understanding machine learning concepts and building models with Python.	introduction-to-machine-learning-2	8
234	Natural Language Processing (NLP)	Text processing with NLTK, spaCy, sentiment analysis, and topic modeling.	natural-language-processing-nlp-2	8
235	Concurrency and Parallelism	Using threading, multiprocessing, and asyncio for parallel programming.	concurrency-and-parallelism	8
236	Python for Web Scraping	Web scraping techniques using BeautifulSoup, Scrapy, and requests.	python-for-web-scraping	8
237	Working with Databases	Connecting to SQL and NoSQL databases using Python, ORM tools like SQLAlchemy.	working-with-databases	8
238	Python Testing and Debugging	Writing unit tests, integration tests using unittest and pytest.	python-testing-and-debugging	8
239	Advanced Python Features	Understanding generators, context managers, decorators, and asynchronous programming.	advanced-python-features	8
240	Creating RESTful APIs with Python	Building and deploying RESTful APIs using Flask or Django REST framework.	creating-restful-apis-with-python	8
241	Python for Cloud Computing	Using Python with AWS, Google Cloud, and Azure for cloud-based applications.	python-for-cloud-computing	8
242	Python and IoT	Using Python with Raspberry Pi, Arduino, and IoT sensors.	python-and-iot	8
243	Deploying Python Applications	Deployment strategies for Python applications using Docker, Heroku, and AWS.	deploying-python-applications	8
244	Python Security Best Practices	Ensuring security in Python applications, encryption, and secure coding practices.	python-security-best-practices	8
245	Python Game Development	Building games with Pygame and other game development libraries.	python-game-development	8
246	GraphQL with Python	Creating and managing GraphQL APIs using Python frameworks.	graphql-with-python	8
247	Working with Big Data in Python	Processing large datasets using Python tools like PySpark and Dask.	working-with-big-data-in-python	8
248	Optimizing Python Applications	Improving performance through code optimization and profiling.	optimizing-python-applications	8
249	Practical Python Projects	Hands-on experience with real-world projects like web scrapers, automation tools, data analysis, and more.	practical-python-projects	8
250	Introduction to Web Design	Basics of web design, including principles, tools, and workflows.	introduction-to-web-design	9
251	HTML Fundamentals	HTML basics, elements, attributes, and semantic markup.	html-fundamentals	9
252	Advanced HTML	HTML5 features, multimedia, forms, and accessibility.	advanced-html	9
253	CSS Fundamentals	CSS basics, selectors, properties, and box model.	css-fundamentals	9
254	Advanced CSS Techniques	Flexbox, Grid, animations, transitions, and transformations.	advanced-css-techniques	9
255	Responsive Web Design	Creating responsive designs using media queries and breakpoints.	responsive-web-design	9
256	CSS Preprocessors	Introduction to Sass and Less for advanced styling.	css-preprocessors	9
257	Tailwind CSS	Utility-first CSS framework for rapid UI development.	tailwind-css	9
258	Bootstrap Framework	Creating responsive layouts with Bootstrap components.	bootstrap-framework	9
259	Flowbite Components	Using Flowbite for pre-built components and Tailwind integration.	flowbite-components	9
260	Introduction to JavaScript	JavaScript basics: syntax, variables, and control structures.	introduction-to-javascript	9
261	Advanced JavaScript	ES6+ features, asynchronous programming, and APIs.	advanced-javascript	9
262	DOM Manipulation and Events	Manipulating the DOM, event handling, and event delegation.	dom-manipulation-and-events	9
263	JavaScript Frameworks Overview	Introduction to popular frameworks like React, Vue, and Angular.	javascript-frameworks-overview	9
264	jQuery Fundamentals	Using jQuery for simplified DOM manipulation and animations.	jquery-fundamentals	9
265	Advanced jQuery Techniques	jQuery plugins, AJAX, and event handling.	advanced-jquery-techniques	9
266	Introduction to Web Animations	Creating animations with CSS, JavaScript, and GSAP.	introduction-to-web-animations	9
267	Web Performance Optimization	Techniques for optimizing web performance, including lazy loading and caching.	web-performance-optimization	9
268	Cross-Browser Compatibility	Ensuring compatibility across different browsers and devices.	cross-browser-compatibility	9
269	Accessibility in Web Design	Designing accessible web content for all users.	accessibility-in-web-design	9
270	SEO Fundamentals	Basics of Search Engine Optimization for web design.	seo-fundamentals	9
271	Web Security Basics	Introduction to web security, HTTPS, and best practices.	web-security-basics	9
272	Introduction to Web Development Tools	Using development tools like VSCode, Git, and browser dev tools.	introduction-to-web-development-tools	9
273	Advanced CSS Frameworks	Exploring Bulma, Foundation, and Materialize for advanced styling.	advanced-css-frameworks	9
274	Modern JavaScript Libraries	Using libraries like Lodash, Moment.js, and D3.js.	modern-javascript-libraries	9
275	Web Design for Mobile	Best practices for designing mobile-first websites.	web-design-for-mobile	9
276	Web Design Trends	Exploring modern trends like Neumorphism, Glassmorphism, and Dark Mode.	web-design-trends	9
277	Introduction to JAMstack	Building static sites with modern tools like Gatsby, Next.js, and Hugo.	introduction-to-jamstack	9
278	Version Control with Git	Using Git for version control and collaboration.	version-control-with-git	9
279	Deploying Web Projects	Deploying websites using Netlify, Vercel, and traditional servers.	deploying-web-projects	9
280	Web Design Project	Capstone project to create a fully functional website.	web-design-project	9
\.


--
-- Data for Name: main_userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.main_userprofile (id, bio, pfp, user_id) FROM stdin;
1	I am the king	\N	1
2	\N	\N	3
3		image/upload/v1727035901/cbggimlnp3yu2ixpolnx.jpg	2
\.


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
2	google	103478614572017864834	2024-09-11 12:19:19.46901+00	2024-09-11 12:19:19.469028+00	{"aud": "861062239972-7clbkvk0jcmjiea7jibck6fd8oe1dept.apps.googleusercontent.com", "azp": "861062239972-7clbkvk0jcmjiea7jibck6fd8oe1dept.apps.googleusercontent.com", "exp": 1726060757, "iat": 1726057157, "iss": "https://accounts.google.com", "sub": "103478614572017864834", "name": "daler jatt", "email": "dalerjatt5911@gmail.com", "at_hash": "pVZ9BNcICvhn-_bLQGX-bA", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKHsylCWmxGR8XkeLRG4GuhmnLwaU9bhhRreHa29p6uI3O-s7gJ=s96-c", "given_name": "daler", "family_name": "jatt", "email_verified": true}	3
1	google	118403704969253707155	2024-09-23 04:32:10.037049+00	2024-09-10 19:49:09.33662+00	{"aud": "861062239972-7clbkvk0jcmjiea7jibck6fd8oe1dept.apps.googleusercontent.com", "azp": "861062239972-7clbkvk0jcmjiea7jibck6fd8oe1dept.apps.googleusercontent.com", "exp": 1727069529, "iat": 1727065929, "iss": "https://accounts.google.com", "sub": "118403704969253707155", "name": "Siddharth Tiwari", "email": "siddharthgreat443@gmail.com", "at_hash": "yWMfG2DXIdLV6mSq0TdxsQ", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLMD0Qvyq94BM3z2bdBVTGOjhsumLFizlp-il9SSKeESvrE-GJtnw=s96-c", "given_name": "Siddharth", "family_name": "Tiwari", "email_verified": true}	2
3	google	101932365405167891216	2024-09-23 13:38:04.372918+00	2024-09-23 13:38:04.372935+00	{"aud": "861062239972-7clbkvk0jcmjiea7jibck6fd8oe1dept.apps.googleusercontent.com", "azp": "861062239972-7clbkvk0jcmjiea7jibck6fd8oe1dept.apps.googleusercontent.com", "exp": 1727102282, "iat": 1727098682, "iss": "https://accounts.google.com", "sub": "101932365405167891216", "name": "Abhishek Bisht", "email": "abhishekbisht0203@gmail.com", "at_hash": "jN6n3GrR6csckEeeAPniBw", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIDlhgie2jQ29GKXRgQKnaTDn7sEcmUupFy5xLXWNRWN2OMxpA=s96-c", "given_name": "Abhishek", "family_name": "Bisht", "email_verified": true}	4
\.


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialapp (id, provider, name, client_id, secret, key, provider_id, settings) FROM stdin;
1	google	Google	REDACTED_GOOGLE_CLIENT_ID	REDACTED_GOOGLE_SECRET	REDACTED_GOOGLE_API_KEY		{}
2	github	Github	REDACTED_GITHUB_CLIENT_ID	REDACTED_GITHUB_SECRET			{}
\.



--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages (id, topic, extension, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2024-08-28 17:58:34
20211116045059	2024-08-28 17:58:35
20211116050929	2024-08-28 17:58:36
20211116051442	2024-08-28 17:58:36
20211116212300	2024-08-28 17:58:37
20211116213355	2024-08-28 17:58:38
20211116213934	2024-08-28 17:58:38
20211116214523	2024-08-28 17:58:39
20211122062447	2024-08-28 17:58:40
20211124070109	2024-08-28 17:58:40
20211202204204	2024-08-28 17:58:41
20211202204605	2024-08-28 17:58:41
20211210212804	2024-08-28 17:58:43
20211228014915	2024-08-28 17:58:44
20220107221237	2024-08-28 17:58:44
20220228202821	2024-08-28 17:58:45
20220312004840	2024-08-28 17:58:46
20220603231003	2024-08-28 17:58:46
20220603232444	2024-08-28 17:58:47
20220615214548	2024-08-28 17:58:48
20220712093339	2024-08-28 17:58:48
20220908172859	2024-08-28 17:58:49
20220916233421	2024-08-28 17:58:49
20230119133233	2024-08-28 17:58:50
20230128025114	2024-08-28 17:58:51
20230128025212	2024-08-28 17:58:51
20230227211149	2024-08-28 17:58:52
20230228184745	2024-08-28 17:58:53
20230308225145	2024-08-28 17:58:53
20230328144023	2024-08-28 17:58:54
20231018144023	2024-08-28 17:58:54
20231204144023	2024-08-28 17:58:55
20231204144024	2024-08-28 17:58:56
20231204144025	2024-08-28 17:58:57
20240108234812	2024-08-28 17:58:57
20240109165339	2024-08-28 17:58:58
20240227174441	2024-08-28 17:58:59
20240311171622	2024-08-28 17:59:00
20240321100241	2024-08-28 17:59:01
20240401105812	2024-08-28 17:59:03
20240418121054	2024-08-28 17:59:03
20240523004032	2024-08-28 17:59:05
20240618124746	2024-08-28 17:59:06
20240801235015	2024-08-28 17:59:07
20240805133720	2024-08-28 17:59:07
20240827160934	2024-09-23 17:15:35
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2024-08-28 17:58:30.778279
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2024-08-28 17:58:30.850978
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2024-08-28 17:58:30.908926
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2024-08-28 17:58:30.948649
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2024-08-28 17:58:31.035862
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2024-08-28 17:58:31.091859
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2024-08-28 17:58:31.147481
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2024-08-28 17:58:31.166288
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2024-08-28 17:58:31.219335
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2024-08-28 17:58:31.230814
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2024-08-28 17:58:31.28783
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2024-08-28 17:58:31.343127
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2024-08-28 17:58:31.399484
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2024-08-28 17:58:31.455291
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2024-08-28 17:58:31.511482
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2024-08-28 17:58:31.551364
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2024-08-28 17:58:31.605222
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2024-08-28 17:58:31.660219
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2024-08-28 17:58:31.720179
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2024-08-28 17:58:31.776623
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2024-08-28 17:58:31.840934
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2024-08-28 17:58:31.903758
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2024-08-28 17:58:31.988334
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2024-08-28 17:58:32.065351
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2024-08-28 17:58:32.123448
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2024-08-28 17:58:32.180641
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 3, true);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 76, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 4, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 19, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 19, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 48, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: main_chatmessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_chatmessage_id_seq', 1, false);


--
-- Name: main_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_comment_id_seq', 1, false);


--
-- Name: main_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_note_id_seq', 18, true);


--
-- Name: main_note_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_note_topics_id_seq', 19, true);


--
-- Name: main_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_question_id_seq', 3, true);


--
-- Name: main_question_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_question_topics_id_seq', 3, true);


--
-- Name: main_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_subject_id_seq', 9, true);


--
-- Name: main_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_topic_id_seq', 280, true);


--
-- Name: main_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.main_userprofile_id_seq', 3, true);


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 3, true);


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 2, true);


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 2, true);


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.messages_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress account_emailaddress_user_id_email_987c8728_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_email_987c8728_uniq UNIQUE (user_id, email);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: main_chatmessage main_chatmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_chatmessage
    ADD CONSTRAINT main_chatmessage_pkey PRIMARY KEY (id);


--
-- Name: main_comment main_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_comment
    ADD CONSTRAINT main_comment_pkey PRIMARY KEY (id);


--
-- Name: main_note main_note_auto_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note
    ADD CONSTRAINT main_note_auto_slug_key UNIQUE (auto_slug);


--
-- Name: main_note main_note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note
    ADD CONSTRAINT main_note_pkey PRIMARY KEY (id);


--
-- Name: main_note_topics main_note_topics_note_id_topic_id_7689a63f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note_topics
    ADD CONSTRAINT main_note_topics_note_id_topic_id_7689a63f_uniq UNIQUE (note_id, topic_id);


--
-- Name: main_note_topics main_note_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note_topics
    ADD CONSTRAINT main_note_topics_pkey PRIMARY KEY (id);


--
-- Name: main_question main_question_auto_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_auto_slug_key UNIQUE (auto_slug);


--
-- Name: main_question main_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_pkey PRIMARY KEY (id);


--
-- Name: main_question_topics main_question_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question_topics
    ADD CONSTRAINT main_question_topics_pkey PRIMARY KEY (id);


--
-- Name: main_question_topics main_question_topics_question_id_topic_id_84b0c63f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question_topics
    ADD CONSTRAINT main_question_topics_question_id_topic_id_84b0c63f_uniq UNIQUE (question_id, topic_id);


--
-- Name: main_subject main_subject_auto_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_subject
    ADD CONSTRAINT main_subject_auto_slug_key UNIQUE (auto_slug);


--
-- Name: main_subject main_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_subject
    ADD CONSTRAINT main_subject_pkey PRIMARY KEY (id);


--
-- Name: main_topic main_topic_auto_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_topic
    ADD CONSTRAINT main_topic_auto_slug_key UNIQUE (auto_slug);


--
-- Name: main_topic main_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_topic
    ADD CONSTRAINT main_topic_pkey PRIMARY KEY (id);


--
-- Name: main_userprofile main_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_userprofile
    ADD CONSTRAINT main_userprofile_pkey PRIMARY KEY (id);


--
-- Name: main_userprofile main_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_userprofile
    ADD CONSTRAINT main_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_provider_uid_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialapp socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: account_emailaddress_email_03be32b2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_email_03be32b2 ON public.account_emailaddress USING btree (email);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: main_chatmessage_receiver_id_a3561138; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_chatmessage_receiver_id_a3561138 ON public.main_chatmessage USING btree (receiver_id);


--
-- Name: main_chatmessage_sender_id_ddbc0976; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_chatmessage_sender_id_ddbc0976 ON public.main_chatmessage USING btree (sender_id);


--
-- Name: main_comment_commented_by_id_3cf5675e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_comment_commented_by_id_3cf5675e ON public.main_comment USING btree (commented_by_id);


--
-- Name: main_comment_note_id_c6f43dc9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_comment_note_id_c6f43dc9 ON public.main_comment USING btree (note_id);


--
-- Name: main_comment_question_id_49e055ea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_comment_question_id_49e055ea ON public.main_comment USING btree (question_id);


--
-- Name: main_note_auto_slug_0366dbc1_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_note_auto_slug_0366dbc1_like ON public.main_note USING btree (auto_slug varchar_pattern_ops);


--
-- Name: main_note_topics_note_id_e190331f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_note_topics_note_id_e190331f ON public.main_note_topics USING btree (note_id);


--
-- Name: main_note_topics_topic_id_ea61b8f6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_note_topics_topic_id_ea61b8f6 ON public.main_note_topics USING btree (topic_id);


--
-- Name: main_note_uploaded_by_id_c252e3a3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_note_uploaded_by_id_c252e3a3 ON public.main_note USING btree (uploaded_by_id);


--
-- Name: main_question_added_by_id_c4377374; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_question_added_by_id_c4377374 ON public.main_question USING btree (added_by_id);


--
-- Name: main_question_auto_slug_687db34a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_question_auto_slug_687db34a_like ON public.main_question USING btree (auto_slug varchar_pattern_ops);


--
-- Name: main_question_topics_question_id_40b0c2df; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_question_topics_question_id_40b0c2df ON public.main_question_topics USING btree (question_id);


--
-- Name: main_question_topics_topic_id_b94a9836; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_question_topics_topic_id_b94a9836 ON public.main_question_topics USING btree (topic_id);


--
-- Name: main_subject_auto_slug_96bef56f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_subject_auto_slug_96bef56f_like ON public.main_subject USING btree (auto_slug varchar_pattern_ops);


--
-- Name: main_topic_auto_slug_086e0ef6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_topic_auto_slug_086e0ef6_like ON public.main_topic USING btree (auto_slug varchar_pattern_ops);


--
-- Name: main_topic_subject_id_1e53ad3e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_topic_subject_id_1e53ad3e ON public.main_topic USING btree (subject_id);


--
-- Name: socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: unique_primary_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_primary_email ON public.account_emailaddress USING btree (user_id, "primary") WHERE "primary";


--
-- Name: unique_verified_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_verified_email ON public.account_emailaddress USING btree (email) WHERE verified;


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING hash (entity);


--
-- Name: messages_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_topic_index ON realtime.messages USING btree (topic);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_chatmessage main_chatmessage_receiver_id_a3561138_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_chatmessage
    ADD CONSTRAINT main_chatmessage_receiver_id_a3561138_fk_auth_user_id FOREIGN KEY (receiver_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_chatmessage main_chatmessage_sender_id_ddbc0976_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_chatmessage
    ADD CONSTRAINT main_chatmessage_sender_id_ddbc0976_fk_auth_user_id FOREIGN KEY (sender_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_comment main_comment_commented_by_id_3cf5675e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_comment
    ADD CONSTRAINT main_comment_commented_by_id_3cf5675e_fk_auth_user_id FOREIGN KEY (commented_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_comment main_comment_note_id_c6f43dc9_fk_main_note_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_comment
    ADD CONSTRAINT main_comment_note_id_c6f43dc9_fk_main_note_id FOREIGN KEY (note_id) REFERENCES public.main_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_comment main_comment_question_id_49e055ea_fk_main_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_comment
    ADD CONSTRAINT main_comment_question_id_49e055ea_fk_main_question_id FOREIGN KEY (question_id) REFERENCES public.main_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_note_topics main_note_topics_note_id_e190331f_fk_main_note_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note_topics
    ADD CONSTRAINT main_note_topics_note_id_e190331f_fk_main_note_id FOREIGN KEY (note_id) REFERENCES public.main_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_note_topics main_note_topics_topic_id_ea61b8f6_fk_main_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note_topics
    ADD CONSTRAINT main_note_topics_topic_id_ea61b8f6_fk_main_topic_id FOREIGN KEY (topic_id) REFERENCES public.main_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_note main_note_uploaded_by_id_c252e3a3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_note
    ADD CONSTRAINT main_note_uploaded_by_id_c252e3a3_fk_auth_user_id FOREIGN KEY (uploaded_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_question main_question_added_by_id_c4377374_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_added_by_id_c4377374_fk_auth_user_id FOREIGN KEY (added_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_question_topics main_question_topics_question_id_40b0c2df_fk_main_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question_topics
    ADD CONSTRAINT main_question_topics_question_id_40b0c2df_fk_main_question_id FOREIGN KEY (question_id) REFERENCES public.main_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_question_topics main_question_topics_topic_id_b94a9836_fk_main_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_question_topics
    ADD CONSTRAINT main_question_topics_topic_id_b94a9836_fk_main_topic_id FOREIGN KEY (topic_id) REFERENCES public.main_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_topic main_topic_subject_id_1e53ad3e_fk_main_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_topic
    ADD CONSTRAINT main_topic_subject_id_1e53ad3e_fk_main_subject_id FOREIGN KEY (subject_id) REFERENCES public.main_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_userprofile main_userprofile_user_id_15c416f4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.main_userprofile
    ADD CONSTRAINT main_userprofile_user_id_15c416f4_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_account_id_951f210e_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_account_id_951f210e_fk_socialacc FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_app_id_636a42d7_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_app_id_636a42d7_fk_socialacc FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_site_id_2579dee5_fk_django_si; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_site_id_2579dee5_fk_django_si FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.try_cast_double(inp text) FROM postgres;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_decode(data text) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_encode(data bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION comment_directive(comment_ text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO postgres;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO anon;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO authenticated;
GRANT ALL ON FUNCTION graphql.comment_directive(comment_ text) TO service_role;


--
-- Name: FUNCTION exception(message text); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.exception(message text) TO postgres;
GRANT ALL ON FUNCTION graphql.exception(message text) TO anon;
GRANT ALL ON FUNCTION graphql.exception(message text) TO authenticated;
GRANT ALL ON FUNCTION graphql.exception(message text) TO service_role;


--
-- Name: FUNCTION get_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.get_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.get_schema_version() TO service_role;


--
-- Name: FUNCTION increment_schema_version(); Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql.increment_schema_version() TO postgres;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO anon;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO authenticated;
GRANT ALL ON FUNCTION graphql.increment_schema_version() TO service_role;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION lo_export(oid, text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_export(oid, text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_export(oid, text) TO supabase_admin;


--
-- Name: FUNCTION lo_import(text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text) TO supabase_admin;


--
-- Name: FUNCTION lo_import(text, oid); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text, oid) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text, oid) TO supabase_admin;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: SEQUENCE seq_schema_version; Type: ACL; Schema: graphql; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE graphql.seq_schema_version TO postgres;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO anon;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO authenticated;
GRANT ALL ON SEQUENCE graphql.seq_schema_version TO service_role;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE account_emailaddress; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.account_emailaddress TO anon;
GRANT ALL ON TABLE public.account_emailaddress TO authenticated;
GRANT ALL ON TABLE public.account_emailaddress TO service_role;


--
-- Name: SEQUENCE account_emailaddress_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.account_emailaddress_id_seq TO anon;
GRANT ALL ON SEQUENCE public.account_emailaddress_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.account_emailaddress_id_seq TO service_role;


--
-- Name: TABLE account_emailconfirmation; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.account_emailconfirmation TO anon;
GRANT ALL ON TABLE public.account_emailconfirmation TO authenticated;
GRANT ALL ON TABLE public.account_emailconfirmation TO service_role;


--
-- Name: SEQUENCE account_emailconfirmation_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.account_emailconfirmation_id_seq TO anon;
GRANT ALL ON SEQUENCE public.account_emailconfirmation_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.account_emailconfirmation_id_seq TO service_role;


--
-- Name: TABLE auth_group; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth_group TO anon;
GRANT ALL ON TABLE public.auth_group TO authenticated;
GRANT ALL ON TABLE public.auth_group TO service_role;


--
-- Name: SEQUENCE auth_group_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.auth_group_id_seq TO anon;
GRANT ALL ON SEQUENCE public.auth_group_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.auth_group_id_seq TO service_role;


--
-- Name: TABLE auth_group_permissions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth_group_permissions TO anon;
GRANT ALL ON TABLE public.auth_group_permissions TO authenticated;
GRANT ALL ON TABLE public.auth_group_permissions TO service_role;


--
-- Name: SEQUENCE auth_group_permissions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.auth_group_permissions_id_seq TO anon;
GRANT ALL ON SEQUENCE public.auth_group_permissions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.auth_group_permissions_id_seq TO service_role;


--
-- Name: TABLE auth_permission; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth_permission TO anon;
GRANT ALL ON TABLE public.auth_permission TO authenticated;
GRANT ALL ON TABLE public.auth_permission TO service_role;


--
-- Name: SEQUENCE auth_permission_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.auth_permission_id_seq TO anon;
GRANT ALL ON SEQUENCE public.auth_permission_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.auth_permission_id_seq TO service_role;


--
-- Name: TABLE auth_user; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth_user TO anon;
GRANT ALL ON TABLE public.auth_user TO authenticated;
GRANT ALL ON TABLE public.auth_user TO service_role;


--
-- Name: TABLE auth_user_groups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth_user_groups TO anon;
GRANT ALL ON TABLE public.auth_user_groups TO authenticated;
GRANT ALL ON TABLE public.auth_user_groups TO service_role;


--
-- Name: SEQUENCE auth_user_groups_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.auth_user_groups_id_seq TO anon;
GRANT ALL ON SEQUENCE public.auth_user_groups_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.auth_user_groups_id_seq TO service_role;


--
-- Name: SEQUENCE auth_user_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.auth_user_id_seq TO anon;
GRANT ALL ON SEQUENCE public.auth_user_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.auth_user_id_seq TO service_role;


--
-- Name: TABLE auth_user_user_permissions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth_user_user_permissions TO anon;
GRANT ALL ON TABLE public.auth_user_user_permissions TO authenticated;
GRANT ALL ON TABLE public.auth_user_user_permissions TO service_role;


--
-- Name: SEQUENCE auth_user_user_permissions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.auth_user_user_permissions_id_seq TO anon;
GRANT ALL ON SEQUENCE public.auth_user_user_permissions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.auth_user_user_permissions_id_seq TO service_role;


--
-- Name: TABLE django_admin_log; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.django_admin_log TO anon;
GRANT ALL ON TABLE public.django_admin_log TO authenticated;
GRANT ALL ON TABLE public.django_admin_log TO service_role;


--
-- Name: SEQUENCE django_admin_log_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.django_admin_log_id_seq TO anon;
GRANT ALL ON SEQUENCE public.django_admin_log_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.django_admin_log_id_seq TO service_role;


--
-- Name: TABLE django_content_type; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.django_content_type TO anon;
GRANT ALL ON TABLE public.django_content_type TO authenticated;
GRANT ALL ON TABLE public.django_content_type TO service_role;


--
-- Name: SEQUENCE django_content_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.django_content_type_id_seq TO anon;
GRANT ALL ON SEQUENCE public.django_content_type_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.django_content_type_id_seq TO service_role;


--
-- Name: TABLE django_migrations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.django_migrations TO anon;
GRANT ALL ON TABLE public.django_migrations TO authenticated;
GRANT ALL ON TABLE public.django_migrations TO service_role;


--
-- Name: SEQUENCE django_migrations_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.django_migrations_id_seq TO anon;
GRANT ALL ON SEQUENCE public.django_migrations_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.django_migrations_id_seq TO service_role;


--
-- Name: TABLE django_session; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.django_session TO anon;
GRANT ALL ON TABLE public.django_session TO authenticated;
GRANT ALL ON TABLE public.django_session TO service_role;


--
-- Name: TABLE django_site; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.django_site TO anon;
GRANT ALL ON TABLE public.django_site TO authenticated;
GRANT ALL ON TABLE public.django_site TO service_role;


--
-- Name: SEQUENCE django_site_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.django_site_id_seq TO anon;
GRANT ALL ON SEQUENCE public.django_site_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.django_site_id_seq TO service_role;


--
-- Name: TABLE main_chatmessage; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_chatmessage TO anon;
GRANT ALL ON TABLE public.main_chatmessage TO authenticated;
GRANT ALL ON TABLE public.main_chatmessage TO service_role;


--
-- Name: SEQUENCE main_chatmessage_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_chatmessage_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_chatmessage_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_chatmessage_id_seq TO service_role;


--
-- Name: TABLE main_comment; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_comment TO anon;
GRANT ALL ON TABLE public.main_comment TO authenticated;
GRANT ALL ON TABLE public.main_comment TO service_role;


--
-- Name: SEQUENCE main_comment_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_comment_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_comment_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_comment_id_seq TO service_role;


--
-- Name: TABLE main_note; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_note TO anon;
GRANT ALL ON TABLE public.main_note TO authenticated;
GRANT ALL ON TABLE public.main_note TO service_role;


--
-- Name: SEQUENCE main_note_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_note_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_note_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_note_id_seq TO service_role;


--
-- Name: TABLE main_note_topics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_note_topics TO anon;
GRANT ALL ON TABLE public.main_note_topics TO authenticated;
GRANT ALL ON TABLE public.main_note_topics TO service_role;


--
-- Name: SEQUENCE main_note_topics_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_note_topics_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_note_topics_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_note_topics_id_seq TO service_role;


--
-- Name: TABLE main_question; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_question TO anon;
GRANT ALL ON TABLE public.main_question TO authenticated;
GRANT ALL ON TABLE public.main_question TO service_role;


--
-- Name: SEQUENCE main_question_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_question_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_question_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_question_id_seq TO service_role;


--
-- Name: TABLE main_question_topics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_question_topics TO anon;
GRANT ALL ON TABLE public.main_question_topics TO authenticated;
GRANT ALL ON TABLE public.main_question_topics TO service_role;


--
-- Name: SEQUENCE main_question_topics_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_question_topics_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_question_topics_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_question_topics_id_seq TO service_role;


--
-- Name: TABLE main_subject; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_subject TO anon;
GRANT ALL ON TABLE public.main_subject TO authenticated;
GRANT ALL ON TABLE public.main_subject TO service_role;


--
-- Name: SEQUENCE main_subject_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_subject_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_subject_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_subject_id_seq TO service_role;


--
-- Name: TABLE main_topic; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_topic TO anon;
GRANT ALL ON TABLE public.main_topic TO authenticated;
GRANT ALL ON TABLE public.main_topic TO service_role;


--
-- Name: SEQUENCE main_topic_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_topic_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_topic_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_topic_id_seq TO service_role;


--
-- Name: TABLE main_userprofile; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.main_userprofile TO anon;
GRANT ALL ON TABLE public.main_userprofile TO authenticated;
GRANT ALL ON TABLE public.main_userprofile TO service_role;


--
-- Name: SEQUENCE main_userprofile_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.main_userprofile_id_seq TO anon;
GRANT ALL ON SEQUENCE public.main_userprofile_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.main_userprofile_id_seq TO service_role;


--
-- Name: TABLE socialaccount_socialaccount; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.socialaccount_socialaccount TO anon;
GRANT ALL ON TABLE public.socialaccount_socialaccount TO authenticated;
GRANT ALL ON TABLE public.socialaccount_socialaccount TO service_role;


--
-- Name: SEQUENCE socialaccount_socialaccount_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.socialaccount_socialaccount_id_seq TO anon;
GRANT ALL ON SEQUENCE public.socialaccount_socialaccount_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.socialaccount_socialaccount_id_seq TO service_role;


--
-- Name: TABLE socialaccount_socialapp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.socialaccount_socialapp TO anon;
GRANT ALL ON TABLE public.socialaccount_socialapp TO authenticated;
GRANT ALL ON TABLE public.socialaccount_socialapp TO service_role;


--
-- Name: SEQUENCE socialaccount_socialapp_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.socialaccount_socialapp_id_seq TO anon;
GRANT ALL ON SEQUENCE public.socialaccount_socialapp_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.socialaccount_socialapp_id_seq TO service_role;


--
-- Name: TABLE socialaccount_socialapp_sites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.socialaccount_socialapp_sites TO anon;
GRANT ALL ON TABLE public.socialaccount_socialapp_sites TO authenticated;
GRANT ALL ON TABLE public.socialaccount_socialapp_sites TO service_role;


--
-- Name: SEQUENCE socialaccount_socialapp_sites_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.socialaccount_socialapp_sites_id_seq TO anon;
GRANT ALL ON SEQUENCE public.socialaccount_socialapp_sites_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.socialaccount_socialapp_sites_id_seq TO service_role;


--
-- Name: TABLE socialaccount_socialtoken; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.socialaccount_socialtoken TO anon;
GRANT ALL ON TABLE public.socialaccount_socialtoken TO authenticated;
GRANT ALL ON TABLE public.socialaccount_socialtoken TO service_role;


--
-- Name: SEQUENCE socialaccount_socialtoken_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.socialaccount_socialtoken_id_seq TO anon;
GRANT ALL ON SEQUENCE public.socialaccount_socialtoken_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.socialaccount_socialtoken_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: SEQUENCE messages_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.messages_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.messages_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.messages_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.messages_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.messages_id_seq TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

