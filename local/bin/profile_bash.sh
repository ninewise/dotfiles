#!/usr/bin/env bash
#
# Assumes file descriptor 3 is not messed with in the profiled script.

pid=$$
exec 3>&2 2> >(tee /tmp/bash_profile-${pid}.log | \
               sed -u 's/^.*$/now/' | \
               date -f - +%s.%N >/tmp/bash_profile-${pid}.tim)
set -x

. "$@"

set +x
exec 2>&3 3>&-

paste <(
    while read tim ;do
        crt=000000000$((${tim//.}-10#0$last))
        printf "%12.9f\n" ${crt:0:${#crt}-9}.${crt:${#crt}-9}
        last=${tim//.}
    done < /tmp/bash_profile-${pid}.tim
) /tmp/bash_profile-${pid}.log > ${pid}.timings

accumulator='
{
    sum[$2] += $1
    count[$2] += 1
}
END {
    printf("command\ttotal\ttimes\taverage\n")
    for (key in sum) {
        printf("%s\t%f\t%d\t%f\n", key, sum[key], count[key], sum[key] / count[key])
    }
}
'

paste \
    <(cut -f1 ${pid}.timings) \
    <(cat /tmp/bash_profile-${pid}.log \
        | sed '/\] *=/c [[assignement]]' \
        | sed -n 's/++* \([^ ]*\).*/\1/p' \
        | sed '/=/c [[assignment]]') \
    | > ${pid}.acc awk "$accumulator"

rm /tmp/bash_profile-${pid}.{tim,log}
echo ${pid}.timings
