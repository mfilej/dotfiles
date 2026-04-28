function __jj_op_log_id
    command jj root >/dev/null 2>/dev/null; or return
    command jj op log --ignore-working-copy --limit 1 --no-graph --template 'id.short()' 2>/dev/null
end

function _tide_item_jj_op_log_id
    _tide_print_item jj_op_log_id $tide_jj_op_log_id_icon' '(__jj_op_log_id)
end
