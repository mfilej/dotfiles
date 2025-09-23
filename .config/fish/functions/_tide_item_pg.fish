function _tide_item_pg
	set -f result ""

	if test -n "$PGDATABASE"
		set result "pg:$PGDATABASE"
	end

	_tide_print_item pg $result
end
