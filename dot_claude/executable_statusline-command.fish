set input (cat)

set model (echo $input | jq -r '.model.display_name')
set used_pct (echo $input | jq -r '.context_window.used_percentage // empty')
set five_hour_pct (echo $input | jq -r '.rate_limits.five_hour.used_percentage // empty')
set seven_day_pct (echo $input | jq -r '.rate_limits.seven_day.used_percentage // empty')

set output $model

if test -n "$used_pct"
    set output "$output ctx:"(printf '%.0f' $used_pct)"%"
end

if test -n "$five_hour_pct"
    set output "$output 5h:"(printf '%.0f' $five_hour_pct)"%"
end

if test -n "$seven_day_pct"
    set output "$output 7d:"(printf '%.0f' $seven_day_pct)"%"
end

printf '%s' $output
