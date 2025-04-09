function __jj_op_log_id
    jj root >/dev/null && jj op log --ignore-working-copy --limit 1 --no-graph --template 'id.short()'
end

function _tide_item_jj_op_log_id
    _tide_print_item jj_op_log_id $tide_jj_op_log_id_icon' '(__jj_op_log_id)
end
