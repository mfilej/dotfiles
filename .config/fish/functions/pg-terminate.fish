function pg-terminate --description "Terminate PostgreSQL backends connected to a database"
    if test (count $argv) -ne 1
        echo "Usage: pg-terminate <dbname>" >&2
        return 1
    end

    set -l dbname $argv[1]
    set -l escaped_dbname (string replace -a "'" "''" -- $dbname)
    set -l drop_command "select pg_terminate_backend(pid) from pg_stat_activity where datname = '$escaped_dbname';"

    psql -d postgres -c "$drop_command"
end
