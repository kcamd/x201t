#!/bin/bash
# apps we want to restart
trayer_pid=$(ps aux | grep '[t]rayer' | awk '{print $2}')
dropbox_pid=$(ps aux | grep '[d]ropbox' | awk '{print $2}')
lrz_sh_pid=$(ps aux | grep '[L]RZ_Sync_Share-Client.sh' | awk '{print $2}')
lrz_jar_pid=$(ps aux | grep '[L]RZ_Sync_Share/jre' | awk '{print $2}')
nm_applet_pid=$(ps aux | grep '[n]m-applet' | awk '{print $2}')

if [[ ${trayer_pid} ]]; then
   kill ${trayer_pid}
else
    /usr/bin/trayer --align right --edge bottom --distance 0 --expand true --monitor 0 --transparent true --alpha 128 --tint 0 --SetDockType true --SetPartialStrut true &> /dev/null &
fi

if [[ ${dropbox_pid} ]]; then
    kill ${dropbox_pid}
else
    /usr/bin/dropbox &> /dev/null &
fi

if [[ ${lrz_sh_pid} ]] && [[ ${lrz_jar_pid} ]]; then
    kill ${lrz_sh_pid}
    kill ${lrz_jar_pid}
else
    /usr/share/LRZ_Sync_Share/LRZ_Sync_Share-Client.sh &> /dev/null &
fi

if [[ ${nm_applet_pid} ]]; then
    kill ${nm_applet_pid}
else
    nm-applet &> /dev/null &
fi





   
