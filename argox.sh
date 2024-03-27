#!/usr/bin/env bash

# 当前脚本版本号
VERSION='1.0.9 (2024.03.26)'

# 各变量默认值
WS_PATH_DEFAULT='sba'
WORK_DIR='/etc/sba'
TEMP_DIR='/tmp/sba'
TLS_SERVER=addons.mozilla.org
CDN_DOMAIN=("cn.azhz.eu.org" "www.who.int" "skk.moe" "time.cloudflare.com" "csgo.com")
SUBSCRIBE_TEMPLATE="https://raw.githubusercontent.com/fscarmen/client_template/main"
SUBSCRIBE_API="api.v1.mk"
METRICS_PORT='3014'
SUBSCRIBE_API=("bav6.889876.xyz" "api.v1.mk")

trap "rm -rf $TEMP_DIR; echo -e '\n' ;exit 1" INT QUIT TERM EXIT

mkdir -p $TEMP_DIR

E[0]="Language:\n 1. English (default) \n 2. 简体中文"
C[0]="${E[0]}"
E[1]="Thanks to UUb for the official change of the compilation, dependencies jq, qrencode from apt installation to download the binary files, reduce the installation time of about 15 seconds, the implementation of the project's positioning of lightweight, as far as possible to install the least system dependencies."
C[1]="感谢 UUb 兄弟的官改编译，依赖 jq, qrencode 从 apt 安装改为下载二进制文件，缩减安装时间约15秒，贯彻项目轻量化的定位，尽最大可能安装最少的系统依赖"
E[2]="Project to create Argo tunnels and Sing-box specifically for VPS, detailed:[https://github.com/fscarmen/sba]\n Features:\n\t • Allows the creation of Argo tunnels via Token, Json and ad hoc methods. User can easily obtain the json at https://fscarmen.cloudflare.now.cc .\n\t • Extremely fast installation method, saving users time.\n\t • Support system: Ubuntu, Debian, CentOS, Alpine and Arch Linux 3.\n\t • Support architecture: AMD,ARM and s390x\n"
C[2]="本项目专为 VPS 添加 Argo 隧道及 Sing-Box,详细说明: [https://github.com/fscarmen/sba]\n 脚本特点:\n\t • 允许通过 Token, Json 及 临时方式来创建 Argo 隧道,用户通过以下网站轻松获取 json: https://fscarmen.cloudflare.now.cc\n\t • 极速安装方式,大大节省用户时间\n\t • 智能判断操作系统: Ubuntu 、Debian 、CentOS 、Alpine 和 Arch Linux,请务必选择 LTS 系统\n\t • 支持硬件结构类型: AMD 和 ARM\n"
E[3]="Input errors up to 5 times.The script is aborted."
C[3]="输入错误达5次,脚本退出"
E[4]="UUID should be 36 characters, please re-enter \(\$[a-1] times remaining\)"
C[4]="UUID 应为36位字符,请重新输入 \(剩余\$[a-1]次\)"
E[5]="The script supports Debian, Ubuntu, CentOS, Alpine, Fedora or Arch systems only. Feedback: [https://github.com/fscarmen/sba/issues]"
C[5]="本脚本只支持 Debian、Ubuntu、CentOS、Alpine、Fedora 或 Arch 系统,问题反馈:[https://github.com/fscarmen/sba/issues]"
E[6]="Curren operating system is \$SYS.\\\n The system lower than \$SYSTEM \${MAJOR[int]} is not supported. Feedback: [https://github.com/fscarmen/sba/issues]"
C[6]="当前操作是 \$SYS\\\n 不支持 \$SYSTEM \${MAJOR[int]} 以下系统,问题反馈:[https://github.com/fscarmen/sba/issues]"
E[7]="Install dependence-list:"
C[7]="安装依赖列表:"
E[8]="All dependencies already exist and do not need to be installed additionally."
C[8]="所有依赖已存在，不需要额外安装"
E[9]="To upgrade, press [y]. No upgrade by default:"
C[9]="升级请按 [y]，默认不升级:"
E[10]="(2/7) Please input Argo Domain (Default is temporary domain if left blank):"
C[10]="(2/7) 请输入 Argo 域名 (如果没有，可以跳过以使用 Argo 临时域名):"
E[11]="Please input Argo Token or Json ( User can easily obtain the json at https://fscarmen.cloudflare.now.cc ):"
C[11]="请输入 Argo Token 或者 Json ( 用户通过以下网站轻松获取 json: https://fscarmen.cloudflare.now.cc ):"
E[12]="\(5/7\) Please input Sing-box UUID \(Default is \$UUID_DEFAULT\):"
C[12]="\(5/7\) 请输入 Sing-box UUID \(默认为 \$UUID_DEFAULT\):"
E[13]="\(6/7\) Please input Sing-box WS Path \(Default is \$WS_PATH_DEFAULT\):"
C[13]="\(6/7\) 请输入 Sing-box WS 路径 \(默认为 \$WS_PATH_DEFAULT\):"
E[14]="Sing-box WS Path only allow uppercase and lowercase letters and numeric characters, please re-enter \(\${a} times remaining\):"
C[14]="Sing-box WS 路径只允许英文大小写及数字字符，请重新输入 \(剩余\${a}次\):"
E[15]="sba script has not been installed yet."
C[15]="sba 脚本还没有安装"
E[16]="sba is completely uninstalled."
C[16]="sba 已彻底卸载"
E[17]="Version"
C[17]="脚本版本"
E[18]="New features"
C[18]="功能新增"
E[19]="System infomation"
C[19]="系统信息"
E[20]="Operating System"
C[20]="当前操作系统"
E[21]="Kernel"
C[21]="内核"
E[22]="Architecture"
C[22]="处理器架构"
E[23]="Virtualization"
C[23]="虚拟化"
E[24]="Choose:"
C[24]="请选择:"
E[25]="Curren architecture \$(uname -m) is not supported. Feedback: [https://github.com/fscarmen/sba/issues]"
C[25]="当前架构 \$(uname -m) 暂不支持,问题反馈:[https://github.com/fscarmen/sba/issues]"
E[26]="Not install"
C[26]="未安装"
E[27]="close"
C[27]="关闭"
E[28]="open"
C[28]="开启"
E[29]="View links (sb -n)"
C[29]="查看节点信息 (sb -n)"
E[30]="Change the Argo tunnel (sb -t)"
C[30]="更换 Argo 隧道 (sb -t)"
E[31]="Sync Argo and Sing-box to the latest version (sb -v)"
C[31]="同步 Argo 和 Sing-box 至最新版本 (sb -v)"
E[32]="Upgrade kernel, turn on BBR, change Linux system (sb -b)"
C[32]="升级内核、安装BBR、DD脚本 (sb -b)"
E[33]="Uninstall (sb -u)"
C[33]="卸载 (sb -u)"
E[34]="Install sba script (argo + sing-box)"
C[34]="安装 sba 脚本 (argo + sing-box)"
E[35]="Exit"
C[35]="退出"
E[36]="Please enter the correct number"
C[36]="请输入正确数字"
E[37]="successful"
C[37]="成功"
E[38]="failed"
C[38]="失败"
E[39]="sba is not installed."
C[39]="sba 未安装"
E[40]="Argo tunnel is: \$ARGO_TYPE\\\n The domain is: \$ARGO_DOMAIN"
C[40]="Argo 隧道类型为: \$ARGO_TYPE\\\n 域名是: \$ARGO_DOMAIN"
E[41]="Argo tunnel type:\n 1. Try\n 2. Token or Json"
C[41]="Argo 隧道类型:\n 1. Try\n 2. Token 或者 Json"
E[42]="\(4/7\) Please select or enter the preferred domain, the default is \${CDN_DOMAIN[0]}:"
C[42]="\(4/7\) 请选择或者填入优选域名，默认为 \${CDN_DOMAIN[0]}:"
E[43]="\$APP local verion: \$LOCAL\\\t The newest verion: \$ONLINE"
C[43]="\$APP 本地版本: \$LOCAL\\\t 最新版本: \$ONLINE"
E[44]="No upgrade required."
C[44]="不需要升级"
E[45]="Argo authentication message does not match the rules, neither Token nor Json, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[45]="Argo 认证信息不符合规则，既不是 Token，也是不是 Json，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[46]="Connect"
C[46]="连接"
E[47]="The script must be run as root, you can enter sudo -i and then download and run again. Feedback:[https://github.com/fscarmen/sba/issues]"
C[47]="必须以root方式运行脚本，可以输入 sudo -i 后重新下载运行，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[48]="Downloading the latest version \$APP failed, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[48]="下载最新版本 \$APP 失败，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[49]="\(7/7\) Please enter the node name. \(Default is \${NODE_NAME_DEFAULT}\):"
C[49]="\(7/7\) 请输入节点名称 \(默认为 \${NODE_NAME_DEFAULT}\):"
E[50]="\${APP[@]} services are not enabled, node information cannot be output. Press [y] if you want to open."
C[50]="\${APP[@]} 服务未开启，不能输出节点信息。如需打开请按 [y]: "
E[51]="Install Sing-box multi-protocol scripts [https://github.com/fscarmen/sing-box]"
C[51]="安装 Sing-box 协议全家桶脚本 [https://github.com/fscarmen/sing-box]"
E[52]="Memory Usage"
C[52]="内存占用"
E[53]="The Sing-box service is detected to be installed, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[53]="检测到已安装 Sing-box 服务，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[54]="Warp / warp-go was detected to be running. Please enter the correct server IP:"
C[54]="检测到 warp / warp-go 正在运行，请输入确认的服务器 IP:"
E[55]="The script runs today: \$TODAY. Total: \$TOTAL"
C[55]="脚本当天运行次数: \$TODAY，累计运行次数: \$TOTAL"
E[56]="\(3/7\) Please enter the Reality port \(Default is \${REALITY_PORT_DEFAULT}\):"
C[56]="\(3/7\) 请输入 Reality 的端口号 \(默认为 \${REALITY_PORT_DEFAULT}\):"
E[57]="\(1/7\) Please enter VPS IP \(Default is: \${SERVER_IP_DEFAULT}\):"
C[57]="\(1/7\) 请输入 VPS IP \(默认为: \${SERVER_IP_DEFAULT}\):"
E[58]="Install ArgoX scripts (argo + xray) [https://github.com/fscarmen/argox]"
C[58]="安装 ArgoX 脚本 (argo + xray) [https://github.com/fscarmen/argox]"
E[59]="To uninstall Nginx press [y], it is not uninstalled by default:"
C[59]="如要卸载 Nginx 请按 [y]，默认不卸载:"
E[60]="Quicktunnel domain can be obtained from: http://\${SERVER_IP_1}:\${METRICS_PORT}/quicktunnel"
C[60]="临时隧道域名可以从以下网站获取: http://\${SERVER_IP_1}:\${METRICS_PORT}/quicktunnel"
E[61]="Enable multiplexing"
C[61]="可开启多路复用"
E[62]="Create shortcut [ sb ] successfully."
C[62]="创建快捷 [ sb ] 指令成功!"
E[63]="The full template can be found at:\n https://t.me/ztvps/67\n https://github.com/chika0801/sing-box-examples/tree/main/Tun"
C[63]="完整模板可参照:\n https://t.me/ztvps/67\n https://github.com/chika0801/sing-box-examples/tree/main/Tun"
E[64]="Install TCP brutal"
C[64]="安装 TCP brutal"
E[65]="No server ip, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[65]="没有 server ip，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[66]="subscribe"
C[66]="订阅"
E[67]="Ports are in used: \$REALITY_PORT"
C[67]="正在使用中的端口: \$REALITY_PORT"
E[68]="Adaptive Clash / V2rayN / NekoBox / ShadowRocket / SFI / SFA / SFM Clients"
C[68]="自适应 Clash / V2rayN / NekoBox / ShadowRocket / SFI / SFA / SFM 客户端"
E[69]="template"
C[69]="模版"
E[70]="Set SElinux: enforcing --> disabled"
C[70]="设置 SElinux: enforcing --> disabled"

# 自定义字体彩色，read 函数
warning() { echo -e "\033[31m\033[01m$*\033[0m"; }  # 红色
error() { echo -e "\033[31m\033[01m$*\033[0m" && exit 1; } # 红色
info() { echo -e "\033[32m\033[01m$*\033[0m"; }   # 绿色
hint() { echo -e "\033[33m\033[01m$*\033[0m"; }   # 黄色
reading() { read -rp "$(info "$1")" "$2"; }
text() { grep -q '\$' <<< "${E[$*]}" && eval echo "\$(eval echo "\${${L}[$*]}")" || eval echo "\${${L}[$*]}"; }

# 自定义友道或谷歌翻译函数
translate() {
  [ -n "$@" ] && EN="$@"
  ZH=$(wget --no-check-certificate -qO- --tries=1 --timeout=2 "https://translate.google.com/translate_a/t?client=any_client_id_works&sl=en&tl=zh&q=${EN//[[:space:]]/%20}" 2>/dev/null)
  [[ "$ZH" =~ ^\[\".+\"\]$ ]] && awk -F '"' '{print $2}' <<< "$ZH"
}

# 检测是否解锁 chatGPT，以决定是否使用 warp 链式代理或者是 direct out
check_chatgpt() {
  local CHECK_STACK=$1
  local SUPPORT_COUNTRY=(AL DZ AD AO AG AR AM AU AT AZ BS BD BB BE BZ BJ BT BO BA BW BR BN BG BF CV CA CL CO KM CG CR CI HR CY CZ DK DJ DM DO EC SV EE FJ FI FR GA GM GE DE GH GR GD GT GN GW GY HT VA HN HU IS IN ID IQ IE IL IT JM JP JO KZ KE KI KW KG LV LB LS LR LI LT LU MG MW MY MV ML MT MH MR MU MX FM MD MC MN ME MA MZ MM NA NR NP NL NZ NI NE NG MK NO OM PK PW PS PA PG PY PE PH PL PT QA RO RW KN LC VC WS SM ST SN RS SC SL SG SK SI SB ZA KR ES LK SR SE CH TW TZ TH TL TG TO TT TN TR TV UG UA AE GB US UY VU ZM)
  [[ "${SUPPORT_COUNTRY[@]}" =~ $(wget --no-check-certificate -$CHECK_STACK -qO- --tries=3 --timeout=2 https://chat.openai.com/cdn-cgi/trace | awk -F '=' '/loc/{print $2}') ]] && echo 'unlock' || echo 'ban'
}

# 脚本当天及累计运行次数统计
statistics_of_run-times() {
  local COUNT=$(wget -qO- --tries=2 --timeout=2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh" 2>&1 | grep -m1 -oE "[0-9]+[ ]+/[ ]+[0-9]+") &&
  TODAY=$(awk -F ' ' '{print $1}' <<< "$COUNT") &&
  TOTAL=$(awk -F ' ' '{print $3}' <<< "$COUNT")
}

# 选择中英语言
select_language() {
  if [ -z "$L" ]; then
    case $(cat $WORK_DIR/language 2>&1) in
      E ) L=E ;;
      C ) L=C ;;
      * ) [ -z "$L" ] && L=E && hint "\n $(text 0) \n" && reading " $(text 24) " LANGUAGE
      [ "$LANGUAGE" = 2 ] && L=C ;;
    esac
  fi
}

check_root() {
  [ "$(id -u)" != 0 ] && error "\n $(text 47) \n"
}

check_arch() {
  # 判断处理器架构
  case $(uname -m) in
    aarch64|arm64 ) ARGO_ARCH=arm64; SING_BOX_ARCH=arm64; JQ_ARCH=arm64; QRENCODE_ARCH=arm64 ;;
    x86_64|amd64 ) ARGO_ARCH=amd64; [[ "$(awk -F ':' '/flags/{print $2; exit}' /proc/cpuinfo)" =~ avx2 ]] && SING_BOX_ARCH=amd64v3 || SING_BOX_ARCH=amd64; JQ_ARCH=amd64; QRENCODE_ARCH=amd64 ;;
    armv7l ) ARGO_ARCH=arm; SING_BOX_ARCH=armv7; JQ_ARCH=armhf; QRENCODE_ARCH=arm ;;
    * ) error " $(text 25) " ;;
  esac
}

# 查安装及运行状态，下标0: argo，下标1: sing-box，下标2：docker；状态码: 26 未安装， 27 已安装未运行， 28 运行中
check_install() {
  STATUS[0]=$(text 26) && [ -s /etc/systemd/system/argo.service ] && STATUS[0]=$(text 27) && [ "$(systemctl is-active argo)" = 'active' ] && STATUS[0]=$(text 28)
  STATUS[1]=$(text 26)
  # sing-box systemd 文件存在的话，检测一下是否本脚本安装的，如果不是则提示并提出
  if [ -s /etc/systemd/system/sing-box.service ]; then
    ! grep -q "$WORK_DIR" /etc/systemd/system/sing-box.service && error " $(text 53)\n $(grep 'ExecStart=' /etc/systemd/system/sing-box.service) "
    STATUS[1]=$(text 27) && [ "$(systemctl is-active sing-box)" = 'active' ] && STATUS[1]=$(text 28)
  fi
  [[ ${STATUS[0]} = "$(text 26)" ]] && [ ! -s $WORK_DIR/cloudflared ] &&
  {
    wget --no-check-certificate -qO $TEMP_DIR/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARGO_ARCH >/dev/null 2>&1
    chmod +x $TEMP_DIR/cloudflared >/dev/null 2>&1
  }&
  [[ ${STATUS[1]} = "$(text 26)" ]] && [ ! -s $WORK_DIR/sing-box ] &&
  {
    local VERSION_LATEST=$(wget --no-check-certificate -qO- "https://api.github.com/repos/SagerNet/sing-box/releases" | awk -F '["v-]' '/tag_name/{print $5}' | sort -r | sed -n '1p')
    local SING_BOX_LATEST=$(wget --no-check-certificate -qO- "https://api.github.com/repos/SagerNet/sing-box/releases" | awk -F '["v]' -v var="tag_name.*$VERSION" '$0 ~ var {print $5; exit}')
    SING_BOX_LATEST=${SING_BOX_LATEST:-'1.9.0-rc.2'}
    wget --no-check-certificate -c $TEMP_DIR/sing-box.tar.gz https://github.com/SagerNet/sing-box/releases/download/v$SING_BOX_LATEST/sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH.tar.gz -qO- | tar xz -C $TEMP_DIR sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH/sing-box
    mv $TEMP_DIR/sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH/sing-box $TEMP_DIR >/dev/null 2>&1
    wget --no-check-certificate --continue -qO $TEMP_DIR/jq https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-$JQ_ARCH >/dev/null 2>&1 && chmod +x $TEMP_DIR/jq >/dev/null 2>&1
    wget --no-check-certificate --continue -qO $TEMP_DIR/qrencode https://github.com/fscarmen/client_template/raw/main/qrencode-go/qrencode-go-linux-$QRENCODE_ARCH >/dev/null 2>&1 && chmod +x $TEMP_DIR/qrencode >/dev/null 2>&1
  }&
}

# 订阅 api 函数，为保证节点数据的安全性，将置换为伪造数据去获取 api 配置信息，之后再置换为真实的
fetch_subscribe() {
  # 1. 获取参数
  local TARGET=$1
  local REAL_FILE=$2
  local URL=$3

  # 2. 获取重点键值，由于 sing-box 使用 v2ray 插件不成功的原因，所以 sing-box 去掉 shadowsocks+WSS 的协议
  [ "$TARGET" = 'singbox' ] && local REAL_CONTENT=$(sed '/type: ss/d' $REAL_FILE) || local REAL_CONTENT=$(cat $REAL_FILE)
  local REAL_NAME=($(sed -n 's/.*\-[ ]*{[ ]*name:[ ]*"\([^"]*\)".*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_SERVER=($(sed -n 's/.*,[ ]*server:[ ]*\([^,]\+\),.*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_SERVERNAME=($(sed -n 's/.*servername:[ ]*\([^,]\+\),.*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_HOST=($(sed -n 's/.*ost:[ ]*\([^,}]\+\).*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_SNI=($(sed -n 's/.*sni:[ ]*\([^,]\+\),.*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_PORT=($(sed -n 's/.*,[ ]*port:[ ]*\([^,]\+\),.*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_UUID=($(sed -n 's/.*,[ ]*uuid:[ ]*\([^,]\+\),.*/\1/gp'  <<< "$REAL_CONTENT"))
  local REAL_PASSWORD=($(sed -n 's/.*,[ ]*password:[ ]*\([^,]\+\),.*/\1/gp' <<< "$REAL_CONTENT"))
  local REAL_PUBLIC=($(sed -n 's/.*{[ ]*public-key:[ ]*\([^,]\+\),.*/\1/gp'  <<< "$REAL_CONTENT"))
  local REAL_PATH=($(sed -n 's/.*path:[ ]*"\/\([^"]\+\)",.*/\1/gp' <<< "$REAL_CONTENT"))

  # 3. 混淆各键值
  local FAKE_CONTENT=$REAL_CONTENT
  local FAKE_FILE=${REAL_FILE}-${TARGET}-fake
  local FAKE_URL=${URL}-${TARGET}-fake

  for d in ${!REAL_NAME[@]}; do
    local FAKE_NAME[d]=$(cat /proc/sys/kernel/random/uuid)
    local FAKE_CONTENT=$(sed "1,/name: \"${REAL_NAME[d]}/s/${REAL_NAME[d]}/${FAKE_NAME[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_SERVER[@]}; do
    local FAKE_SERVER[d]="$(cat /proc/sys/kernel/random/uuid)"
    local FAKE_CONTENT=$(sed "1,/server: ${REAL_SERVER[d]}/s/server: ${REAL_SERVER[d]}/server: ${FAKE_SERVER[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_SERVERNAME[@]}; do
    local FAKE_SERVERNAME[d]="$(cat /proc/sys/kernel/random/uuid)"
    local FAKE_CONTENT=$(sed "1,/servername: ${REAL_SERVERNAME[d]}/s/servername: ${REAL_SERVERNAME[d]}/servername: ${FAKE_SERVERNAME[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_SNI[@]}; do
    local FAKE_SNI[d]="$(cat /proc/sys/kernel/random/uuid)"
    local FAKE_CONTENT=$(sed "1,/sni: ${REAL_SNI[d]}/s/sni: ${REAL_SNI[d]}/sni: ${FAKE_SNI[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_HOST[@]}; do
    local FAKE_HOST[d]="$(cat /proc/sys/kernel/random/uuid)"
    local FAKE_CONTENT=$(sed "1,/ost: ${REAL_HOST[d]}/s/ost: ${REAL_HOST[d]}/ost: ${FAKE_HOST[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_PORT[@]}; do
    local FAKE_PORT[d]=$(shuf -i 10000-65535 -n 1)
    local FAKE_CONTENT=$(sed "1,/port: ${REAL_PORT[d]}/s/port: ${REAL_PORT[d]}/port: ${FAKE_PORT[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_UUID[@]}; do
    local FAKE_UUID[d]=$(cat /proc/sys/kernel/random/uuid)
    local FAKE_CONTENT=$(sed "1,/uuid: ${REAL_UUID[d]}/s/uuid: ${REAL_UUID[d]}/uuid: ${FAKE_UUID[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_PASSWORD[@]}; do
    local FAKE_PASSWORD[d]=$(cat /proc/sys/kernel/random/uuid)
    local FAKE_CONTENT=$(sed "1,/password: ${REAL_PASSWORD[d]}/s/password: ${REAL_PASSWORD[d]}/password: ${FAKE_PASSWORD[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_PUBLIC[@]}; do
    local FAKE_PUBLIC[d]=$(cat /proc/sys/kernel/random/uuid)
    local FAKE_CONTENT=$(sed "1,/public-key: ${REAL_PUBLIC[d]}/s/public-key: ${REAL_PUBLIC[d]}/public-key: ${FAKE_PUBLIC[d]}/" <<< "$FAKE_CONTENT")
  done
  for d in ${!REAL_PATH[@]}; do
    local FAKE_PATH[d]=$(cat /proc/sys/kernel/random/uuid)
    local FAKE_CONTENT=$(sed "1,/path: \"${REAL_PATH[d]}\"/s#path: \"/${REAL_PATH[d]}#path: \"/${FAKE_PATH[d]}#" <<< "$FAKE_CONTENT")
  done

  # 4. 把混淆节点保存到本地，以让外网能访问
  echo "$FAKE_CONTENT" > $FAKE_FILE

  # 5. 通过转订阅后端 api 获取配置信息
  FROM_API=$(wget --no-check-certificate -qO- --tries=3 --timeout=2 "https://${SUBSCRIBE_API[0]}/sub?target=$TARGET&url=$FAKE_URL&insert=false&config=https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/config/ACL4SSR_Online.ini&emoji=true&list=false&tfo=false&scv=false&fdn=false&sort=false&new_name=true")

  # 6. 删除临时文件
  rm -f $FAKE_FILE

  # 7. 还原数据
  local REAL_CONFIG="$FROM_API"
  for d in ${!FAKE_NAME[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_NAME[d]}/${REAL_NAME[d]}/g" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_SERVER[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_SERVER[d]}/${REAL_SERVER[d]}/g" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_SERVERNAME[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_SERVERNAME[d]}/${REAL_SERVERNAME[d]}/" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_SNI[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_SNI[d]}/${REAL_SNI[d]}/g" <<< "$REAL_CONFIG")
  done
  ### 此处修正理订阅服务里存在的 bug，在 trojan + WSS 协议转换中，server_name 本应是 sni 独立的，转换中 server_name 与 sni 一样了，故修正回来
  local REAL_CONFIG=$(sed "s/${FAKE_SNI[0]}/${FAKE_HOST[2]}/" <<< "$REAL_CONFIG")
  for d in ${!FAKE_HOST[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_HOST[d]}/${REAL_HOST[d]}/" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_PORT[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_PORT[d]}/${REAL_PORT[d]}/g" <<<"$REAL_CONFIG")
  done
  for d in ${!FAKE_UUID[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_UUID[d]}/${REAL_UUID[d]}/g" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_PASSWORD[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_PASSWORD[d]}/${REAL_PASSWORD[d]}/g" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_PUBLIC[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_PUBLIC[d]}/${REAL_PUBLIC[d]}/g" <<< "$REAL_CONFIG")
  done
  for d in ${!FAKE_PATH[@]}; do
    local REAL_CONFIG=$(sed "s/${FAKE_PATH[d]}/${REAL_PATH[d]}/g" <<< "$REAL_CONFIG")
  done

  # 8. 输出最终真实结果
  echo "$REAL_CONFIG"
}

# 为了适配 alpine，定义 cmd_systemctl 的函数
cmd_systemctl() {
  local ENABLE_DISABLE=$1
  local APP=$2
  if [ "$ENABLE_DISABLE" = 'enable' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      systemctl start $APP
      cat > /etc/local.d/$APP.start << EOF
#!/usr/bin/env bash

systemctl start $APP
EOF
      chmod +x /etc/local.d/$APP.start
      rc-update add local >/dev/null 2>&1
    elif [ "$IS_CENTOS" = 'CentOS7' ]; then
      systemctl enable --now $APP
      [ "$APP" = 'argo' ] && $(type -p nginx) -c $WORK_DIR/nginx.conf
    else
      systemctl enable --now $APP
    fi

  elif [ "$ENABLE_DISABLE" = 'disable' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      systemctl stop $APP
      [ "$APP" = 'argo' ] && ss -nltp | grep "$(cat /var/run/nginx.pid)" | tr ',' '\n' | awk -F '=' '/pid/{print $2}' | xargs kill -15 >/dev/null 2>&1
      rm -f /etc/local.d/$APP.start
    elif [ "$IS_CENTOS" = 'CentOS7' ]; then
      systemctl disable --now $APP
      [ "$APP" = 'argo' ] && ss -nltp | grep "$(cat /var/run/nginx.pid)" | tr ',' '\n' | awk -F '=' '/pid/{print $2}' | xargs kill -15 >/dev/null 2>&1      
    else
      systemctl disable --now $APP
    fi
  fi
}

check_system_info() {
  # 判断虚拟化
  if [ $(type -p systemd-detect-virt) ]; then
    VIRT=$(systemd-detect-virt)
  elif [ $(type -p hostnamectl) ]; then
    VIRT=$(hostnamectl | awk '/Virtualization/{print $NF}')
  elif [ $(type -p virt-what) ]; then
    VIRT=$(virt-what)
  fi

  [ -s /etc/os-release ] && SYS="$(awk -F '"' 'tolower($0) ~ /pretty_name/{print $2}' /etc/os-release)"
  [[ -z "$SYS" && $(type -p hostnamectl) ]] && SYS="$(hostnamectl | awk -F ': ' 'tolower($0) ~ /operating system/{print $2}')"
  [[ -z "$SYS" && $(type -p lsb_release) ]] && SYS="$(lsb_release -sd)"
  [[ -z "$SYS" && -s /etc/lsb-release ]] && SYS="$(awk -F '"' 'tolower($0) ~ /distrib_description/{print $2}' /etc/lsb-release)"
  [[ -z "$SYS" && -s /etc/redhat-release ]] && SYS="$(cat /etc/redhat-release)"
  [[ -z "$SYS" && -s /etc/issue ]] && SYS="$(sed -E '/^$|^\\/d' /etc/issue | awk -F '\' '{print $1}' | sed 's/[ ]*$//g')"

  REGEX=("debian" "ubuntu" "centos|red hat|kernel|alma|rocky" "arch linux" "alpine" "fedora")
  RELEASE=("Debian" "Ubuntu" "CentOS" "Arch" "Alpine" "Fedora")
  EXCLUDE=("")
  MAJOR=("9" "16" "7" "3" "" "37")
  PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update" "pacman -Sy" "apk update -f" "dnf -y update")
  PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install" "pacman -S --noconfirm" "apk add --no-cache" "dnf -y install")
  PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove" "pacman -Rcnsu --noconfirm" "apk del -f" "dnf -y autoremove")

  for int in "${!REGEX[@]}"; do
    [[ "${SYS,,}" =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && break
  done
  [ -z "$SYSTEM" ] && error " $(text 5) "

  # 针对各厂商的订制系统
  if [ -z "$SYSTEM" ]; then
    [ $(type -p yum) ] && int=2 && SYSTEM='CentOS' || error " $(text 5) "
  fi

  # 先排除 EXCLUDE 里包括的特定系统，其他系统需要作大发行版本的比较
  for ex in "${EXCLUDE[@]}"; do [[ ! "{$SYS,,}"  =~ $ex ]]; done &&
  [[ "$(echo "$SYS" | sed "s/[^0-9.]//g" | cut -d. -f1)" -lt "${MAJOR[int]}" ]] && error " $(text 6) "

  # 针对部分系统作特殊处理
  [ "$SYSTEM" = 'CentOS' ] && IS_CENTOS="CentOS$(echo "$SYS" | sed "s/[^0-9.]//g" | cut -d. -f1)"
}

check_system_ip() {
  if [ -z "$VARIABLE_FILE" ]; then
    # 检测 IPv4 IPv6 信息，WARP Ineterface 开启，普通还是 Plus账户 和 IP 信息
    IP4=$(wget -4 -qO- --no-check-certificate --user-agent=Mozilla --tries=2 --timeout=3 http://ip-api.com/json/) &&
    WAN4=$(expr "$IP4" : '.*query\":[ ]*\"\([^"]*\).*') &&
    COUNTRY4=$(expr "$IP4" : '.*country\":[ ]*\"\([^"]*\).*') &&
    ASNORG4=$(expr "$IP4" : '.*isp\":[ ]*\"\([^"]*\).*') &&
    [[ "$L" = C && -n "$COUNTRY4" ]] && COUNTRY4=$(translate "$COUNTRY4")

    IP6=$(wget -6 -qO- --no-check-certificate --user-agent=Mozilla --tries=2 --timeout=3 https://api.ip.sb/geoip) &&
    WAN6=$(expr "$IP6" : '.*ip\":[ ]*\"\([^"]*\).*') &&
    COUNTRY6=$(expr "$IP6" : '.*country\":[ ]*\"\([^"]*\).*') &&
    ASNORG6=$(expr "$IP6" : '.*isp\":[ ]*\"\([^"]*\).*') &&
    [[ "$L" = C && -n "$COUNTRY6" ]] && COUNTRY6=$(translate "$COUNTRY6")
  fi
}

# 定义 Argo 变量，遇到使用 warp 的话，要求输入正确的 IP
argo_variable() {
  if grep -qi 'cloudflare' <<< "$ASNORG4$ASNORG6"; then
    local a=6
    until [ -n "$SERVER_IP" ]; do
      ((a--)) || true
      [ "$a" = 0 ] && error "\n $(text 3) \n"
      reading "\n $(text 54) " SERVER_IP
    done
    if [[ "$SERVER_IP" =~ : ]]; then
      WARP_ENDPOINT=2606:4700:d0::a29f:c101
      DOMAIN_STRATEG=prefer_ipv6
    else
      WARP_ENDPOINT=162.159.193.10
      DOMAIN_STRATEG=prefer_ipv4
    fi
  elif [ -n "$WAN4" ]; then
    SERVER_IP_DEFAULT=$WAN4
    WARP_ENDPOINT=162.159.193.10
    DOMAIN_STRATEG=prefer_ipv4
  elif [ -n "$WAN6" ]; then
    SERVER_IP_DEFAULT=$WAN6
    WARP_ENDPOINT=2606:4700:d0::a29f:c101
    DOMAIN_STRATEG=prefer_ipv6
  fi

  # 检测是否解锁 chatGPT
  CHAT_GPT_OUT_V4=warp-IPv4-out; CHAT_GPT_OUT_V6=warp-IPv6-out;
  [ "$(check_chatgpt ${DOMAIN_STRATEG: -1})" = 'unlock' ] && CHAT_GPT_OUT_V4=direct && CHAT_GPT_OUT_V6=direct

  # 输入服务器 IP,默认为检测到的服务器 IP，如果全部为空，则提示并退出脚本
  [ -z "$SERVER_IP" ] && reading "\n $(text 57) " SERVER_IP
  SERVER_IP=${SERVER_IP:-"$SERVER_IP_DEFAULT"}
  [ -z "$SERVER_IP" ] && error " $(text 65) "

  # 处理可能输入的错误，去掉开头和结尾的空格，去掉最后的 :
  [ -z "$ARGO_DOMAIN" ] && reading "\n $(text 10) " ARGO_DOMAIN
  ARGO_DOMAIN=$(sed 's/[ ]*//g; s/:[ ]*//' <<< "$ARGO_DOMAIN")

  if [[ -n "$ARGO_DOMAIN" && -z "$ARGO_AUTH" ]]; then
    local a=5
    until [[ "$ARGO_AUTH" =~ TunnelSecret || "$ARGO_AUTH" =~ ^[A-Z0-9a-z=]{120,250}$ || "$ARGO_AUTH" =~ .*cloudflared.*service[[:space:]]+install[[:space:]]+[A-Z0-9a-z=]{1,100} ]]; do
      [ "$a" = 0 ] && error "\n $(text 3) \n" || reading "\n $(text 11) " ARGO_AUTH
      if [[ "$ARGO_AUTH" =~ TunnelSecret ]]; then
        ARGO_JSON=${ARGO_AUTH//[ ]/}
      elif [[ "$ARGO_AUTH" =~ ^[A-Z0-9a-z=]{120,250}$ ]]; then
        ARGO_TOKEN=$ARGO_AUTH
      elif [[ "$ARGO_AUTH" =~ .*cloudflared.*service[[:space:]]+install[[:space:]]+[A-Z0-9a-z=]{1,100} ]]; then
        ARGO_TOKEN=$(awk -F ' ' '{print $NF}' <<< "$ARGO_AUTH")
      else
        warning "\n $(text 45) \n"
      fi
      ((a--)) || true
    done
  fi
}

# 定义 Sing-box 变量
sing_box_variable() {
  local a=6
  until [ -n "$REALITY_PORT" ]; do
    ((a--)) || true
    [ "$a" = 0 ] && error "\n $(text 3) \n"
    REALITY_PORT_DEFAULT=$(shuf -i 100-65535 -n 1)
    reading "\n $(text 56) " REALITY_PORT
    REALITY_PORT=${REALITY_PORT:-"$REALITY_PORT_DEFAULT"}
    ss -nltup | grep ":$REALITY_PORT" >/dev/null 2>&1 && warning "\n $(text 67) \n" && unset REALITY_PORT
  done

  # 提供网上热心网友的anycast域名
  if [ -z "$SERVER" ]; then
    echo ""
    for c in "${!CDN_DOMAIN[@]}"; do
      hint " $[c+1]. ${CDN_DOMAIN[c]} "
    done

    reading "\n $(text 42) " CUSTOM_CDN
    case "$CUSTOM_CDN" in
      [1-${#CDN_DOMAIN[@]}] )
        SERVER="${CDN_DOMAIN[$((CUSTOM_CDN-1))]}"
      ;;
      ?????* )
        SERVER="$CUSTOM_CDN"
      ;;
      * )
        SERVER="${CDN_DOMAIN[0]}"
    esac
  fi

  local a=6
  until [[ "${UUID,,}" =~ ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$ ]]; do
    (( a-- )) || true
    [ "$a" = 0 ] && error "\n $(text 3) \n"
    UUID_DEFAULT=$(cat /proc/sys/kernel/random/uuid)
    reading "\n $(text 12) " UUID
    UUID=${UUID:-"$UUID_DEFAULT"}
    [[ ! "${UUID,,}" =~ ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$ && "$a" != 1 ]] && warning "\n $(text 4) "
  done

  [ -z "$WS_PATH" ] && reading "\n $(text 13) " WS_PATH
  local a=5
  until [[ -z "$WS_PATH" || "$WS_PATH" =~ ^[A-Z0-9a-z]+$ ]]; do
    (( a-- )) || true
    [ "$a" = 0 ] && error " $(text 3) " || reading " $(text 14) " WS_PATH
  done
  WS_PATH=${WS_PATH:-"$WS_PATH_DEFAULT"}

  # 输入节点名，以系统的 hostname 作为默认
  if [ -z "$NODE_NAME" ]; then
    if [ $(type -p hostname) ]; then
      NODE_NAME_DEFAULT="$(hostname)"
    elif [ -s /etc/hostname ]; then
      NODE_NAME_DEFAULT="$(cat /etc/hostname)"
    else
      NODE_NAME_DEFAULT="sba"
    fi
    reading "\n $(text 49) " NODE_NAME
    NODE_NAME="${NODE_NAME:-"$NODE_NAME_DEFAULT"}"
  fi
}

check_dependencies() {
  # 如果是 Alpine，先升级 wget ，安装 systemctl-py 版
  if [ "$SYSTEM" = 'Alpine' ]; then
    CHECK_WGET=$(wget 2>&1 | head -n 1)
    grep -qi 'busybox' <<< "$CHECK_WGET" && ${PACKAGE_INSTALL[int]} wget >/dev/null 2>&1

    local DEPS_CHECK=("bash" "rc-update" "virt-what" "python3")
    local DEPS_INSTALL=("bash" "openrc" "virt-what" "python3")
    for g in "${!DEPS_CHECK[@]}"; do
      [ ! $(type -p ${DEPS_CHECK[g]}) ] && DEPS_ALPINE+=(${DEPS_INSTALL[g]})
    done
    if [ "${#DEPS_ALPINE[@]}" -ge 1 ]; then
      info "\n $(text 7) $(sed "s/ /,&/g" <<< ${DEPS_ALPINE[@]}) \n"
      ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
      ${PACKAGE_INSTALL[int]} ${DEPS_ALPINE[@]} >/dev/null 2>&1
      [[ -z "$VIRT" && "${DEPS_ALPINE[@]}" =~ 'virt-what' ]] && VIRT=$(virt-what)      
    fi

    [ ! $(type -p systemctl) ] && wget --no-check-certificate --quiet https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -O /bin/systemctl && chmod a+x /bin/systemctl
  fi

  # 检测 Linux 系统的依赖，升级库并重新安装依赖
  local DEPS_CHECK=("wget" "systemctl" "ss" "tar" "bash" "nginx" "openssl")
  local DEPS_INSTALL=("wget" "systemctl" "iproute2" "tar" "bash" "nginx" "openssl")

  for g in "${!DEPS_CHECK[@]}"; do
    [ ! $(type -p ${DEPS_CHECK[g]}) ] && DEPS+=(${DEPS_INSTALL[g]})
  done

  if [ "${#DEPS[@]}" -ge 1 ]; then
    info "\n $(text 7) $(sed "s/ /,&/g" <<< ${DEPS[@]}) \n"
    [ "$SYSTEM" != 'CentOS' ] && ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
    ${PACKAGE_INSTALL[int]} ${DEPS[@]} >/dev/null 2>&1
  else
    info "\n $(text 8) \n"
  fi

  # 如果新安装的 Nginx ，先停掉服务
  [[ "${DEPS[@]}" =~ 'nginx' ]] && cmd_systemctl disable nginx >/dev/null 2>&1
}


# 处理防火墙规则
check_firewall_configuration() {
  if [[ -s /etc/selinux/config && $(type -p getenforce) && $(getenforce) = 'Enforcing' ]]; then
    hint "\n $(text 70) \n"
    setenforce 0
    sed -i 's/^SELINUX=.*/# &/; /SELINUX=/a\SELINUX=disabled' /etc/selinux/config
  fi
}

# Nginx 配置文件
json_nginx() {
  if [ -s $WORK_DIR/sing-box-conf/*inbound*.json ]; then
    JSON=$(cat $WORK_DIR/sing-box-conf/*inbound*.json)
    WS_PATH=$(expr "$JSON" : '.*path":"/\(.*\)-vl.*')
    SERVER_IP=${SERVER_IP:-"$(awk -F '"' '/"SERVER_IP"/{print $4}' <<< "$JSON")"}
    UUID=$(awk -F '"' '/"password"/{print $4}' <<< "$JSON")
  fi

  [[ "$SERVER_IP" =~ : ]] && REVERSE_IP="[$SERVER_IP]" || REVERSE_IP="$SERVER_IP"
  cat > $WORK_DIR/nginx.conf << EOF
user  root;
worker_processes  auto;

error_log  /dev/null;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
  map \$http_user_agent \$path1 {
    default                    /;                # 默认路径
    ~*v2rayN|Neko              /base64;          # 匹配 V2rayN / NekoBox 客户端
    ~*clash                    /clash;           # 匹配 Clash 客户端
    ~*ShadowRocket             /shadowrocket;    # 匹配 ShadowRocket  客户端
    ~*SFM                      /sing-box-pc;     # 匹配 Sing-box pc 客户端
    ~*SFI|SFA                  /sing-box-phone;  # 匹配 Sing-box phone 客户端
 #   ~*Chrome|Firefox|Mozilla  /;                # 添加更多的分流规则
  }

  map \$http_user_agent \$path2 {
    default                    /;                # 默认路径
    ~*v2rayN|Neko              /base64;          # 匹配 V2rayN / NekoBox 客户端
    ~*clash                    /clash2;          # 匹配 Clash 客户端
    ~*ShadowRocket             /shadowrocket;    # 匹配 ShadowRocket  客户端
    ~*SFM|SFI|SFA              /sing-box2;       # 匹配 Sing-box pc 和 phone 客户端
 #   ~*Chrome|Firefox|Mozilla  /;                # 添加更多的分流规则
  }

    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /dev/null;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    #include /etc/nginx/conf.d/*.conf;

  server {
    listen 127.0.0.1:3010 ssl http2; # sing-box backend
    # http2 on;
    server_name $TLS_SERVER;

    ssl_certificate            $WORK_DIR/cert/cert.pem;
    ssl_certificate_key        $WORK_DIR/cert/private.key;
    ssl_protocols              TLSv1.3;
    ssl_session_tickets        on;
    ssl_stapling               off;
    ssl_stapling_verify        off;

    # 反代 sing-box vless websocket
    location /$WS_PATH-vl {
      if (\$http_upgrade != "websocket") {
         return 404;
      }
      proxy_pass                          http://127.0.0.1:3011;
      proxy_http_version                  1.1;
      proxy_set_header Upgrade            \$http_upgrade;
      proxy_set_header Connection         "upgrade";
      proxy_set_header X-Real-IP          \$remote_addr;
      proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
      proxy_set_header Host               \$host;
      proxy_redirect                      off;
    }

    # 反代 sing-box websocket
    location /$WS_PATH-vm {
      if (\$http_upgrade != "websocket") {
         return 404;
      }
      proxy_pass                          http://127.0.0.1:3012;
      proxy_http_version                  1.1;
      proxy_set_header Upgrade            \$http_upgrade;
      proxy_set_header Connection         "upgrade";
      proxy_set_header X-Real-IP          \$remote_addr;
      proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
      proxy_set_header Host               \$host;
      proxy_redirect                      off;
    }

    location /$WS_PATH-tr {
      if (\$http_upgrade != "websocket") {
         return 404;
      }
      proxy_pass                          http://127.0.0.1:3013;
      proxy_http_version                  1.1;
      proxy_set_header Upgrade            \$http_upgrade;
      proxy_set_header Connection         "upgrade";
      proxy_set_header X-Real-IP          \$remote_addr;
      proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
      proxy_set_header Host               \$host;
      proxy_redirect                      off;
    }

    # 来自 /auto2 的分流
    location ~ ^/${UUID}/auto2 {
      default_type 'text/plain; charset=utf-8';
      alias ${WORK_DIR}/subscribe/\$path2;
    }

    # 来自 /auto 的分流
    location ~ ^/${UUID}/auto {
      default_type 'text/plain; charset=utf-8';
      alias ${WORK_DIR}/subscribe/\$path1;
    }

    location ~ ^/${UUID}/(.*) {
      autoindex on;
      proxy_set_header X-Real-IP \$proxy_protocol_addr;
      default_type 'text/plain; charset=utf-8';
      alias ${WORK_DIR}/subscribe/\$1;
    }
  }
}
EOF
}

# Json 生成两个配置文件
json_argo() {
  [ ! -s $WORK_DIR/tunnel.json ] && echo $ARGO_JSON > $WORK_DIR/tunnel.json
  [ ! -s $WORK_DIR/tunnel.yml ] && cat > $WORK_DIR/tunnel.yml << EOF
tunnel: $(cut -d\" -f12 <<< $ARGO_JSON)
credentials-file: $WORK_DIR/tunnel.json

ingress:
  - hostname: ${ARGO_DOMAIN}
    service: https://localhost:3010
    originRequest:
      noTLSVerify: true
  - service: http_status:404
EOF
}

# 安装 sba 主程序
install_sba() {
  argo_variable
  sing_box_variable
  [ "$SYSTEM" = 'CentOS' ] && check_firewall_configuration
  wait
  [ ! -d /etc/systemd/system ] && mkdir -p /etc/systemd/system
  mkdir -p $WORK_DIR/sing-box-conf $WORK_DIR/subscribe $WORK_DIR/logs $WORK_DIR/cert && echo "$L" > $WORK_DIR/language
  [ -s "$VARIABLE_FILE" ] && cp $VARIABLE_FILE $WORK_DIR/

  # 把临时目录下载的可执行二进制文件移动到工作目录
  for g in {cloudflared,jq,qrencode}; do
    [[ ! -s $WORK_DIR/$g && -x $TEMP_DIR/$g ]] && mv $TEMP_DIR/$g $WORK_DIR
  done

  if [[ -n "${ARGO_JSON}" && -n "${ARGO_DOMAIN}" ]]; then
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --config $WORK_DIR/tunnel.yml run"
    json_argo
  elif [[ -n "${ARGO_TOKEN}" && -n "${ARGO_DOMAIN}" ]]; then
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto run --token ${ARGO_TOKEN}"
  else
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --no-autoupdate --no-tls-verify --metrics 0.0.0.0:$METRICS_PORT --url https://localhost:3010"
  fi

  # 生成100年的自签证书
  openssl ecparam -genkey -name prime256v1 -out $WORK_DIR/cert/private.key && openssl req -new -x509 -days 36500 -key $WORK_DIR/cert/private.key -out $WORK_DIR/cert/cert.pem -subj "/CN=$(awk -F . '{print $(NF-1)"."$NF}' <<< "$TLS_SERVER")"

  # Argo 生成守护进程文件
  local ARGO_SERVER="[Unit]
Description=Cloudflare Tunnel
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0"
  [ "$IS_CENTOS" != 'CentOS7' ] && ARGO_SERVER+="
ExecStartPre=$(type -p nginx) -c $WORK_DIR/nginx.conf"
  ARGO_SERVER+="
ExecStart=$ARGO_RUNS
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target"

  echo "$ARGO_SERVER" > /etc/systemd/system/argo.service

  # 生成配置文件及守护进程文件
  # 等待 sing-box 二进制文件下载成功并搬到 $WORK_DIR，40秒超时报错退出
  local i=1
  [ ! -s $WORK_DIR/sing-box ] && wait && while [ "$i" -le 20 ]; do [ -s $TEMP_DIR/sing-box ] && mv $TEMP_DIR/sing-box $WORK_DIR && break; ((i++)); sleep 2; done
  [ "$i" -ge 20 ] && local APP=Sing-box && error "\n $(text 48) "

  # 生成 reality 的公私钥
  REALITY_KEYPAIR=$($WORK_DIR/sing-box generate reality-keypair)
  [ -z "$REALITY_PRIVATE" ] && REALITY_PRIVATE=$(awk '/PrivateKey/{print $NF}' <<< "$REALITY_KEYPAIR")
  [ -z "$REALITY_PUBLIC" ] && REALITY_PUBLIC=$(awk '/PublicKey/{print $NF}' <<< "$REALITY_KEYPAIR")
  cat > $WORK_DIR/sing-box-conf/inbound.json << EOF
//  "SERVER_IP":"${SERVER_IP}"
//  "REALITY_PUBLIC":"${REALITY_PUBLIC}"
//  "SERVER":"${SERVER}"
{
    "log":{
        "disabled":false,
        "level":"error",
        "output":"$WORK_DIR/logs/box.log",
        "timestamp":true
    },
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "$WORK_DIR/cache.db"
        }
    },
    "inbounds":[
        {
            "type":"vless",
            "tag":"${NODE_NAME} vless-reality-vision",
            "listen":"::",
            "listen_port":${REALITY_PORT},
            "users":[
                {
                    "uuid":"${UUID}",
                    "flow":""
                }
            ],
            "tls":{
                "enabled":true,
                "server_name":"${TLS_SERVER}",
                "reality":{
                    "enabled":true,
                    "handshake":{
                        "server":"127.0.0.1",
                        "server_port":3010
                    },
                    "private_key":"${REALITY_PRIVATE}",
                    "short_id":[
                        ""
                    ]
                }
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":true,
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            }
        },
        {
            "type":"vless",
            "tag":"vless-in",
            "listen":"127.0.0.1",
            "listen_port":3011,
            "sniff":true,
            "sniff_override_destination":true,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-vl",
                "max_early_data":2048,
                "early_data_header_name":"Sec-WebSocket-Protocol"
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":true,
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            },
            "users":[
                {
                    "uuid":"${UUID}",
                    "flow":""
                }
            ]
        },
        {
            "type":"vmess",
            "tag":"vmess-in",
            "listen":"127.0.0.1",
            "listen_port":3012,
            "sniff":true,
            "sniff_override_destination":true,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-vm",
                "max_early_data":2048,
                "early_data_header_name":"Sec-WebSocket-Protocol"
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":true,
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            },
            "users":[
                {
                    "uuid":"${UUID}",
                    "alterId":0
                }
            ]
        },
        {
            "type":"trojan",
            "tag":"trojan-in",
            "listen":"127.0.0.1",
            "listen_port":3013,
            "sniff":true,
            "sniff_override_destination":true,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-tr",
                "max_early_data":2048,
                "early_data_header_name":"Sec-WebSocket-Protocol"
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":true,
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            },
            "users":[
                {
                    "password":"${UUID}"
                }
            ]
        }
    ]
}
EOF
  cat > $WORK_DIR/sing-box-conf/outbound.json << EOF
{
    "outbounds":[
        {
            "type":"direct",
            "tag":"direct",
            "domain_strategy":"${DOMAIN_STRATEG}"
        },
        {
            "type":"direct",
            "tag":"warp-IPv4-out",
            "detour":"wireguard-out",
            "domain_strategy":"ipv4_only"
        },
        {
            "type":"direct",
            "tag":"warp-IPv6-out",
            "detour":"wireguard-out",
            "domain_strategy":"ipv6_only"
        },
        {
            "type":"wireguard",
            "tag":"wireguard-out",
            "server":"${WARP_ENDPOINT}",
            "server_port":2408,
            "local_address":[
                "172.16.0.2/32",
                "2606:4700:110:8a36:df92:102a:9602:fa18/128"
            ],
            "private_key":"YFYOAdbw1bKTHlNNi+aEjBM3BO7unuFC5rOkMRAz9XY=",
            "peer_public_key":"bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[
                78,
                135,
                76
            ],
            "mtu":1280
        },
        {
            "type":"block",
            "tag":"block"
        }
    ],
    "route":{
        "rule_set":[
            {
                "tag":"geosite-openai",
                "type":"remote",
                "format":"binary",
                "url":"https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-openai.srs"
            }
        ],
        "rules":[
            {
                "domain":"api.openai.com",
                "outbound":"$CHAT_GPT_OUT_V4"
            },
            {
                "rule_set":"geosite-openai",
                "outbound":"$CHAT_GPT_OUT_V6"
            }
        ]
    }
}
EOF

  cat > /etc/systemd/system/sing-box.service << EOF
[Unit]
Description=sing-box service
Documentation=https://sing-box.sagernet.org
After=network.target nss-lookup.target

[Service]
User=root
WorkingDirectory=$WORK_DIR
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
ExecStart=$WORK_DIR/sing-box run -C $WORK_DIR/sing-box-conf
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure
RestartSec=10
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF

  # 生成 Nginx 配置文件
  json_nginx

  # 再次检测状态，运行 Argo 和 Sing-box
  check_install
  case "${STATUS[0]}" in
    "$(text 26)" )
      warning "\n Argo $(text 28) $(text 38) \n"
      ;;
    "$(text 27)" )
      cmd_systemctl enable argo && info "\n Argo $(text 28) $(text 37) \n"
      ;;
    "$(text 28)" )
      info "\n Argo $(text 28) $(text 37) \n"
  esac

  case "${STATUS[0]}" in
    "$(text 26)" )
      warning "\n Sing-box $(text 28) $(text 38) \n"
      ;;
    "$(text 27)" )
      cmd_systemctl enable sing-box && info "\n Sing-box $(text 28) $(text 37) \n"
      ;;
    "$(text 28)" )
      info "\n Sing-box $(text 28) $(text 37) \n"
  esac
}

# 创建快捷方式
create_shortcut() {
  cat > $WORK_DIR/sb.sh << EOF
#!/usr/bin/env bash

bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh) \$1
EOF
  chmod +x $WORK_DIR/sb.sh
  ln -sf $WORK_DIR/sb.sh /usr/bin/sb
  [ -s /usr/bin/sb ] && hint "\n $(text 62) "
}

export_list() {
  check_install

  # v1.0.9 处理的 jq 和 qrencode 二进制文件代替系统依赖的问题，此处预计6月30日删除
  [[ ! -s $WORK_DIR/jq && -s /usr/bin/jq ]] && cp /usr/bin/jq $WORK_DIR/
  if [ ! -s $WORK_DIR/qrencode ]; then
    check_arch
    wget -qO $WORK_DIR/qrencode https://github.com/fscarmen/client_template/raw/main/qrencode-go/qrencode-go-linux-$QRENCODE_ARCH && chmod +x $WORK_DIR/qrencode
  fi

  # 没有开启 Argo 和 Sing-box 服务，将不输出节点信息
  local APP
  [ "${STATUS[0]}" != "$(text 28)" ] && APP+=(argo)
  [ "${STATUS[1]}" != "$(text 28)" ] && APP+=(sing-box)
  if [ "${#APP[@]}" -gt 0 ]; then
    reading "\n $(text 50) " OPEN_APP
    if [ "${OPEN_APP,,}" = 'y' ]; then
      [ "${STATUS[0]}" != "$(text 28)" ] && cmd_systemctl enable argo
      [ "${STATUS[1]}" != "$(text 28)" ] && cmd_systemctl enable sing-box
    else
      exit
    fi
  fi

  # 如果是临时隧道，即实时获取其域名
  if grep -q 'metrics.*url' /etc/systemd/system/argo.service; then
    local a=5
    until [[ -n "$ARGO_DOMAIN" || "$a" = 0 ]]; do
      sleep 2
      ARGO_DOMAIN=$(wget -qO- http://localhost:$(sed -n 's/.*--metrics.*:\([0-9]\+\) .*/\1/gp' /etc/systemd/system/argo.service)/quicktunnel | awk -F '"' '{print $4}')
      ((a--)) || true
    done
  else
    ARGO_DOMAIN=${ARGO_DOMAIN:-"$(grep -m1 '^trojan' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")"}
  fi
  JSON=$(cat $WORK_DIR/sing-box-conf/*inbound*.json)
  SERVER_IP=${SERVER_IP:-"$(awk -F '"' '/"SERVER_IP"/{print $4}' <<< "$JSON")"}
  REALITY_PORT=${REALITY_PORT:-"$(awk -F '[:,]' '/"listen_port"/{print $2; exit}' <<< "$JSON")"}
  REALITY_PUBLIC=${REALITY_PUBLIC:-"$(awk -F '"' '/"REALITY_PUBLIC"/{print $4}' <<< "$JSON")"}
  REALITY_PRIVATE=${REALITY_PRIVATE:-"$(awk -F '"' '/"private_key"/{print $4}' <<< "$JSON")"}
  TLS_SERVER=${TLS_SERVER:-"$(awk -F '"' '/"server_name"/{print $4}' <<< "$JSON")"}
  SERVER=${SERVER:-"$(awk -F '"' '/"SERVER"/{print $4}' <<< "$JSON")"}
  UUID=${UUID:-"$(awk -F '"' '/"password"/{print $4}' <<< "$JSON")"}
  WS_PATH=${WS_PATH:-"$(expr "$JSON" : '.*path":"/\(.*\)-vl.*')"}
  NODE_NAME=${NODE_NAME:-"$(sed -n 's/.*tag":"\(.*\) vless-reality-vision.*/\1/gp' <<< "$JSON")"}

  # IPv6 时的 IP 处理
  if [[ "$SERVER_IP" =~ : ]]; then
    SERVER_IP_1="[$SERVER_IP]"
    SERVER_IP_2="[[$SERVER_IP]]"
  else
    SERVER_IP_1="$SERVER_IP"
    SERVER_IP_2="$SERVER_IP"
  fi

  # 若为临时隧道，处理查询方法
  grep -q 'metrics.*url' /etc/systemd/system/argo.service && QUICK_TUNNEL_URL=$(text 60)

  # 生成 vmess 文件
  VMESS="{ \"v\": \"2\", \"ps\": \"${NODE_NAME}-Vm\", \"add\": \"${SERVER}\", \"port\": \"443\", \"id\": \"${UUID}\", \"aid\": \"0\", \"scy\": \"none\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"${ARGO_DOMAIN}\", \"path\": \"/${WS_PATH}-vm?ed=2048\", \"tls\": \"tls\", \"sni\": \"${ARGO_DOMAIN}\", \"alpn\": \"\" }"

  # 生成各订阅文件
  # 生成 Clash proxy providers 订阅文件
  local CLASH_SUBSCRIBE="proxies:
  - {name: \"${NODE_NAME} vless-reality-vision\", type: vless, server: ${SERVER_IP}, port: ${REALITY_PORT}, uuid: ${UUID}, network: tcp, udp: true, tls: true, servername: ${TLS_SERVER}, client-fingerprint: chrome, reality-opts: {public-key: ${REALITY_PUBLIC}, short-id: \"\"}, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false } }
  - {name: \"${NODE_NAME}-Vl\", type: vless, server: ${SERVER}, port: 443, uuid: ${UUID}, tls: true, servername: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: \"/${WS_PATH}-vl\", headers: { Host: ${ARGO_DOMAIN}}, max-early-data: 2048, early-data-header-name: Sec-WebSocket-Protocol}, udp: true, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false } }
  - {name: \"${NODE_NAME}-Vm\", type: vmess, server: ${SERVER}, port: 443, uuid: ${UUID}, alterId: 0, cipher: none, tls: true, skip-cert-verify: true, servername: ${ARGO_DOMAIN}, network: ws, ws-opts: { path: \"/${WS_PATH}-vm\", headers: { Host: ${ARGO_DOMAIN}}, max-early-data: 2048, early-data-header-name: Sec-WebSocket-Protocol}, udp: true, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false } }
  - {name: \"${NODE_NAME}-Tr\", type: trojan, server: ${SERVER}, port: 443, password: ${UUID}, udp: true, tls: true, sni: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: \"/${WS_PATH}-tr\", headers: { Host: ${ARGO_DOMAIN}}, max-early-data: 2048, early-data-header-name: Sec-WebSocket-Protocol}, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false } }"

  echo -n "${CLASH_SUBSCRIBE}" > $WORK_DIR/subscribe/proxies

  # 生成 clash 订阅配置文件
  wget --no-check-certificate -qO- --tries=3 --timeout=2 ${SUBSCRIBE_TEMPLATE}/clash | sed "s#NODE_NAME#${NODE_NAME}#g; s#PROXY_PROVIDERS_URL#http://${ARGO_DOMAIN}/${UUID}/proxies#" > $WORK_DIR/subscribe/clash

  fetch_subscribe clash $WORK_DIR/subscribe/proxies https://${ARGO_DOMAIN}/${UUID}/proxies > $WORK_DIR/subscribe/clash2

  # 生成 ShadowRocket 订阅文件
  local SHADOWROCKET_SUBSCRIBE="vless://$(echo -n "auto:${UUID}@${SERVER_IP_2}:${REALITY_PORT}" | base64 -w0)?remarks=${NODE_NAME}%20vless-reality-vision&obfs=none&tls=1&peer=$TLS_SERVER&mux=1&pbk=$REALITY_PUBLIC
vless://$(echo -n "auto:${UUID}@${SERVER}:443" | base64 -w0)?remarks=${NODE_NAME}-Vl&obfsParam=${ARGO_DOMAIN}&path=/${WS_PATH}-vl?ed=2048&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&mux=1
vmess://$(echo -n "none:${UUID}@${SERVER}:443" | base64 -w0)?remarks=${NODE_NAME}-Vm&obfsParam=${ARGO_DOMAIN}&path=/${WS_PATH}-vm?ed=2048&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&mux=1&alterId=0
trojan://${UUID}@${SERVER}:443?peer=${ARGO_DOMAIN}&mux=1&plugin=obfs-local;obfs=websocket;obfs-host=${ARGO_DOMAIN};obfs-uri=/${WS_PATH}-tr?ed=2048#${NODE_NAME}-Tr"

  echo -n "${SHADOWROCKET_SUBSCRIBE}" | base64 -w0 > $WORK_DIR/subscribe/shadowrocket

  # 生成 V2rayN / NekoBox 订阅文件
  local V2RAYN_SUBSCRIBE="vless://${UUID}@${SERVER_IP_1}:${REALITY_PORT}?security=reality&sni=${TLS_SERVER}&fp=chrome&pbk=${REALITY_PUBLIC}&type=tcp&encryption=none#${NODE_NAME}%20vless-reality-vision
vless://${UUID}@${SERVER}:443?encryption=none&security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WS_PATH}-vl%3Fed%3D2048#${NODE_NAME}-Vl
vmess://$(echo -n "$VMESS" | base64 -w0)
trojan://${UUID}@${SERVER}:443?security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WS_PATH}-tr%3Fed%3D2048#${NODE_NAME}-Tr"

  echo -n "${V2RAYN_SUBSCRIBE}" | base64 -w0 > $WORK_DIR/subscribe/base64

  # 生成 Sing-box 订阅文件
  local INBOUND_REPLACE="{ \"type\":\"vless\", \"tag\":\"${NODE_NAME} vless-reality-vision\", \"server\":\"${SERVER_IP}\", \"server_port\":${REALITY_PORT}, \"uuid\":\"${UUID}\", \"flow\":\"\", \"packet_encoding\":\"xudp\", \"tls\":{ \"enabled\":true, \"server_name\":\"${TLS_SERVER}\", \"utls\":{ \"enabled\":true, \"fingerprint\":\"chrome\" }, \"reality\":{ \"enabled\":true, \"public_key\":\"${REALITY_PUBLIC}\", \"short_id\":\"\" } }, \"multiplex\":{ \"enabled\":true, \"protocol\":\"h2mux\", \"max_connections\":16, \"padding\": true, \"brutal\":{ \"enabled\":true, \"up_mbps\":1000, \"down_mbps\":1000 } } }, { \"type\": \"vless\", \"tag\": \"${NODE_NAME}-Vl\", \"server\":\"${SERVER}\", \"server_port\":443, \"uuid\":\"${UUID}\", \"tls\": { \"enabled\":true, \"server_name\":\"${ARGO_DOMAIN}\", \"utls\": { \"enabled\":true, \"fingerprint\":\"chrome\" } }, \"transport\": { \"type\":\"ws\", \"path\":\"/${WS_PATH}-vl\", \"headers\": { \"Host\": \"${ARGO_DOMAIN}\" }, \"max_early_data\":2408, \"early_data_header_name\":\"Sec-WebSocket-Protocol\" }, \"multiplex\": { \"enabled\":true, \"protocol\":\"h2mux\", \"max_streams\":16, \"padding\": true, \"brutal\":{ \"enabled\":true, \"up_mbps\":1000, \"down_mbps\":1000 } } }, { \"type\": \"vmess\", \"tag\": \"${NODE_NAME}-Vm\", \"server\":\"${SERVER}\", \"server_port\":443, \"uuid\":\"${UUID}\", \"tls\": { \"enabled\":true, \"server_name\":\"${ARGO_DOMAIN}\", \"utls\": { \"enabled\":true, \"fingerprint\":\"chrome\" } }, \"transport\": { \"type\":\"ws\", \"path\":\"/${WS_PATH}-vm\", \"headers\": { \"Host\": \"${ARGO_DOMAIN}\" }, \"max_early_data\":2408, \"early_data_header_name\":\"Sec-WebSocket-Protocol\" }, \"multiplex\": { \"enabled\":true, \"protocol\":\"h2mux\", \"max_streams\":16, \"padding\": true, \"brutal\":{ \"enabled\":true, \"up_mbps\":1000, \"down_mbps\":1000 } } }, { \"type\":\"trojan\", \"tag\":\"${NODE_NAME}-Tr\", \"server\": \"${SERVER}\", \"server_port\": 443, \"password\": \"${UUID}\", \"tls\": { \"enabled\":true, \"server_name\":\"${ARGO_DOMAIN}\", \"utls\": { \"enabled\":true, \"fingerprint\":\"chrome\" } }, \"transport\": { \"type\":\"ws\", \"path\":\"/${WS_PATH}-tr\", \"headers\": { \"Host\": \"${ARGO_DOMAIN}\" }, \"max_early_data\":2408, \"early_data_header_name\":\"Sec-WebSocket-Protocol\" }, \"multiplex\": { \"enabled\":true, \"protocol\":\"h2mux\", \"max_connections\": 16, \"padding\": true, \"brutal\":{ \"enabled\":true, \"up_mbps\":1000, \"down_mbps\":1000 } } }"
  local NODE_REPLACE="\"${NODE_NAME} vless-reality-vision\", \"${NODE_NAME}-Vl\", \"${NODE_NAME}-Vm\", \"${NODE_NAME}-Tr\""

  # 模板1
  local SING_BOX_JSON1=$(wget --no-check-certificate -qO- --tries=3 --timeout=2 ${SUBSCRIBE_TEMPLATE}/sing-box1)
  echo $SING_BOX_JSON1 | sed 's#, {[^}]\+"tun-in"[^}]\+}##' | sed "s#\"<INBOUND_REPLACE>\"#$INBOUND_REPLACE#; s#\"<NODE_REPLACE>\"#$NODE_REPLACE#g" | $WORK_DIR/jq > $WORK_DIR/subscribe/sing-box-pc
  echo $SING_BOX_JSON1 | sed 's# {[^}]\+"mixed"[^}]\+},##; s#, "auto_detect_interface": true##' | sed "s#\"<INBOUND_REPLACE>\"#$INBOUND_REPLACE#; s#\"<NODE_REPLACE>\"#$NODE_REPLACE#g" | $WORK_DIR/jq > $WORK_DIR/subscribe/sing-box-phone

  # 模板2
  fetch_subscribe singbox $WORK_DIR/subscribe/proxies https://${ARGO_DOMAIN}/${UUID}/proxies | $WORK_DIR/jq > $WORK_DIR/subscribe/sing-box2

  # 生成二维码 url 文件
  cat > $WORK_DIR/subscribe/qr << EOF
$(text 69) 1:
https://${ARGO_DOMAIN}/${UUID}/auto

$(text 69) 2:
https://${ARGO_DOMAIN}/${UUID}/auto2

$(text 66) QRcode:
$(text 69) 1:
https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://${ARGO_DOMAIN}/${UUID}/auto

$(text 69) 2:
https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://${ARGO_DOMAIN}/${UUID}/auto2

$(text 69) 1:
$($WORK_DIR/qrencode "https://${ARGO_DOMAIN}/${UUID}/auto")

$(text 69) 2:
$($WORK_DIR/qrencode "https://${ARGO_DOMAIN}/${UUID}/auto2")
EOF

  # 生成客户端配置文件
  cat > $WORK_DIR/list << EOF
*******************************************
┌────────────────┐  ┌────────────────┐
│                │  │                │
│     $(warning "V2rayN")     │  │    $(warning "NekoBox")     │
│                │  │                │
└────────────────┘  └────────────────┘
----------------------------

$(info "$(sed "G" <<< "${V2RAYN_SUBSCRIBE}")

+++++ $(text 61) +++++")

*******************************************
┌────────────────┐
│                │
│  $(warning "ShadowRocket")  │
│                │
└────────────────┘
----------------------------

$(hint "$(sed "G" <<< "${SHADOWROCKET_SUBSCRIBE}")")

*******************************************
┌────────────────┐
│                │
│   $(warning "Clash Meta")   │
│                │
└────────────────┘
----------------------------

$(info "$(sed '1d;G' <<< "$CLASH_SUBSCRIBE")")

*******************************************
┌────────────────┐
│                │
│    $(warning "Sing-box")    │
│                │
└────────────────┘
----------------------------

$(hint "$(echo "{ \"outbounds\":[ ${INBOUND_REPLACE%,} ] }" | $WORK_DIR/jq)

 $(text 63)")

*******************************************

$(info "Index:
https://${ARGO_DOMAIN}/${UUID}/

QR code:
https://${ARGO_DOMAIN}/${UUID}/qr

V2rayN / Nekoray $(text 66):
https://${ARGO_DOMAIN}/${UUID}/base64")

$(info "Clash $(text 66):
https://${ARGO_DOMAIN}/${UUID}/clash
https://${ARGO_DOMAIN}/${UUID}/clash2

sing-box for pc $(text 66):
https://${ARGO_DOMAIN}/${UUID}/sing-box-pc

sing-box for cellphone $(text 66):
https://${ARGO_DOMAIN}/${UUID}/sing-box-phone

SFI / SFA / SFM $(text 66):
http://${SERVER_IP_1}:${PORT_NGINX}/${UUID_CONFIRM}/sing-box2

ShadowRocket $(text 66):
https://${ARGO_DOMAIN}/${UUID}/shadowrocket")

*******************************************

$(hint " $(text 68):
$(text 69) 1:
https://${ARGO_DOMAIN}/${UUID}/auto

$(text 69) 2:
https://${ARGO_DOMAIN}/${UUID}/auto2

 $(text 66) QRcode:
$(text 69) 1:
https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://${ARGO_DOMAIN}/${UUID}/auto

$(text 69) 2:
https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://${ARGO_DOMAIN}/${UUID}/auto2")

$(hint "$(text 69) 1:")
$($WORK_DIR/qrencode https://${ARGO_DOMAIN}/${UUID}/auto)

$(hint "$(text 69) 2:")
$($WORK_DIR/qrencode https://${ARGO_DOMAIN}/${UUID}/auto2)

*******************************************

$(info " ${QUICK_TUNNEL_URL} ")
EOF

  # 显示节点信息
  cat $WORK_DIR/list

  # 显示脚本使用情况数据
  hint "\n $(text 55) \n"
}

# 更换 Argo 隧道类型
change_argo() {
  check_install
  [[ ${STATUS[0]} = "$(text 26)" ]] && error " $(text 39) "
  SERVER_IP=$(awk -F '"' '/"SERVER_IP"/{print $4}' $WORK_DIR/sing-box-conf/*inbound*.json)

  case $(grep "ExecStart=" /etc/systemd/system/argo.service) in
    *--config* )
      ARGO_TYPE='Json'; ARGO_DOMAIN="$(grep -m1 '^vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")" ;;
    *--token* )
      ARGO_TYPE='Token'; ARGO_DOMAIN="$(grep -m1 '^vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")" ;;
    * )
      ARGO_TYPE='Try'; ARGO_DOMAIN=$(wget -qO- http://localhost:$(sed -n 's/.*--metrics.*:\([0-9]\+\) .*/\1/gp' /etc/systemd/system/argo.service)/quicktunnel | awk -F '"' '{print $4}') ;;
  esac

  hint "\n $(text 40) \n"
  unset ARGO_DOMAIN
  hint " $(text 41) \n" && reading " $(text 24) " CHANGE_TO
    case "$CHANGE_TO" in
      1 )
        cmd_systemctl disable argo
        [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
        sed -i "s@ExecStart=.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --no-autoupdate --no-tls-verify --metrics 0.0.0.0:$METRICS_PORT --url https://localhost:3010@g" /etc/systemd/system/argo.service
        ;;
      2 )
        SERVER_IP=$(awk -F '"' '/"SERVER_IP"/{print $4}' $WORK_DIR/sing-box-conf/*inbound*.json)
        argo_variable
        cmd_systemctl disable argo
        if [ -n "$ARGO_TOKEN" ]; then
          [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
          sed -i "s@ExecStart=.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto run --token ${ARGO_TOKEN}@g" /etc/systemd/system/argo.service
        elif [ -n "$ARGO_JSON" ]; then
          [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
          json_argo
          sed -i "s@ExecStart=.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --config $WORK_DIR/tunnel.yml run@g" /etc/systemd/system/argo.service
        fi
        ;;
      * )
        exit 0
    esac

    json_nginx
    cmd_systemctl enable argo
    export_list
}

uninstall() {
  if [ -d $WORK_DIR ]; then
    cmd_systemctl disable argo
    cmd_systemctl disable sing-box
    rm -rf $WORK_DIR $TEMP_DIR /etc/systemd/system/{sing-box,argo}.service /usr/bin/sb
    [ $(ps -ef | grep 'nginx' | wc -l) -le 1 ] && reading "\n $(text 59) " REMOVE_NGINX
    [ "${REMOVE_NGINX,,}" = 'y' ] && ${PACKAGE_UNINSTALL[int]} nginx >/dev/null 2>&1
    info "\n $(text 16) \n"
  else
    error "\n $(text 15) \n"
  fi

  # 如果 Alpine 系统，删除开机自启动和python3版systemd
  if [ "$SYSTEM" = 'Alpine' ]; then
    rm -f /etc/local.d/argo.start /etc/local.d/sing-box.start
    rc-update add local >/dev/null 2>&1
    [ ! $(ls /etc/systemd/system/*.service) ] && rm -f /bin/systemctl
  fi
}

# Argo 与 Sing-box 的最新版本
version() {
  # Argo 版本
  local ONLINE=$(wget --no-check-certificate -qO- "https://api.github.com/repos/cloudflare/cloudflared/releases/latest" | awk -F '"' '/"tag_name"/{print $4}')
  local LOCAL=$($WORK_DIR/cloudflared -v | awk '{for (i=0; i<NF; i++) if ($i=="version") {print $(i+1)}}')
  local APP=ARGO && info "\n $(text 43) "
  [[ -n "$ONLINE" && "$ONLINE" != "$LOCAL" ]] && reading "\n $(text 9) " UPDATE[0] || info " $(text 44) "
  local VERSION_LATEST=$(wget --no-check-certificate -qO- "https://api.github.com/repos/SagerNet/sing-box/releases" | awk -F '["v-]' '/tag_name/{print $5}' | sort -r | sed -n '1p')
  local ONLINE=$(wget --no-check-certificate -qO- "https://api.github.com/repos/SagerNet/sing-box/releases" | awk -F '["v]' -v var="tag_name.*$VERSION_LATEST" '$0 ~ var {print $5; exit}')
  local LOCAL=$($WORK_DIR/sing-box version | awk '/version/{print $NF}')
  local APP=Sing-box && info "\n $(text 43) "
  [[ -n "$ONLINE" && "$ONLINE" != "$LOCAL" ]] && reading "\n $(text 9) " UPDATE[1] || info " $(text 44) "

  [[ ${UPDATE[*],,} =~ 'y' ]] && check_system_info
  if [ ${UPDATE[0],,} = 'y' ]; then
    wget --no-check-certificate -O $TEMP_DIR/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARGO_ARCH
    if [ -s $TEMP_DIR/cloudflared ]; then
      cmd_systemctl disable argo
      chmod +x $TEMP_DIR/cloudflared && mv $TEMP_DIR/cloudflared $WORK_DIR/cloudflared
      cmd_systemctl enable argo && [ "$(systemctl is-active argo)" = 'active' ] && info " Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "
    else
      local APP=ARGO && error "\n $(text 48) "
    fi
  fi
  if [ ${UPDATE[1],,} = 'y' ]; then
    wget --no-check-certificate -c https://github.com/SagerNet/sing-box/releases/download/v$ONLINE/sing-box-$ONLINE-linux-$SING_BOX_ARCH.tar.gz -qO- | tar xz -C $TEMP_DIR sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box
    if [ -s $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box ]; then
      cmd_systemctl disable sing-box
      mv $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box $WORK_DIR
      rm -rf $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH
      cmd_systemctl enable sing-box && [ "$(systemctl is-active sing-box)" = 'active' ] && info " Sing-box $(text 28) $(text 37)" || error " Sing-box  $(text 28) $(text 38) "
    else
      local APP=Sing-box && error "\n $(text 48) "
    fi
  fi
}

# 判断当前 sba 的运行状态，并对应的给菜单和动作赋值
menu_setting() {
  if [[ ${STATUS[*]} =~ $(text 27)|$(text 28) ]]; then
    if [ -s $WORK_DIR/cloudflared ]; then
      ARGO_VERSION=$($WORK_DIR/cloudflared -v | awk '{print $3}' | sed "s@^@Version: &@g")
      [ $(ps -ef | grep "metrics.*:3010" | wc -l) -gt 1 ] && ARGO_CHECKHEALTH="$(text 46): $(wget --no-check-certificate -qO- http://localhost:$(ps -ef | awk -F '0.0.0.0:' '/cloudflared.*:3010/{print $2}' | awk 'NR==1 {print $1}')/healthcheck | sed "s/OK/$(text 37)/")"
    fi
    [ -s $WORK_DIR/sing-box ] && SING_BOX_VERSION=$($WORK_DIR/sing-box version | awk '/version/{print $NF}' | sed "s@^@Version: &@g")
    [ "$SYSTEM" = 'Alpine' ] && PS_LIST=$(ps -ef) || PS_LIST=$(ps -ef | grep -E 'sing-box|cloudflared|nginx' | awk '{ $1=""; sub(/^ */, ""); print $0 }')
    [ $(type -p nginx) ] && NGINX_VERSION=$(nginx -v 2>&1 | sed "s#.*/#Version: #")

    OPTION[1]="1 .  $(text 29)"
    if [ ${STATUS[0]} = "$(text 28)" ]; then
      AEGO_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$(awk '/\/etc\/sba\/cloudflared/{print $1}' <<< "$PS_LIST")/status) MB"
      NGINX_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$(awk '/\/etc\/sba\/nginx/{print $1}' <<< "$PS_LIST")/status) MB"
      OPTION[2]="2 .  $(text 27) Argo (sb -a)"
    else
      OPTION[2]="2 .  $(text 28) Argo (sb -a)"
    fi
    [ ${STATUS[1]} = "$(text 28)" ] && SING_BOX_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$(awk '/\/etc\/sba\/sing-box.*\/etc\/sba/{print $1}' <<< "$PS_LIST")/status) MB" && OPTION[3]="3 .  $(text 27) Sing-box (sb -s)" || OPTION[3]="3 .  $(text 28) Sing-box (sb -s)"
    OPTION[4]="4 .  $(text 30)"
    OPTION[5]="5 .  $(text 31)"
    OPTION[6]="6 .  $(text 32)"
    OPTION[7]="7 .  $(text 33)"
    OPTION[8]="8 .  $(text 51)"
    OPTION[9]="9 .  $(text 58)"
    OPTION[10]="10.  $(text 64)"

    ACTION[1]() { export_list; }
    [[ ${STATUS[0]} = "$(text 28)" ]] && ACTION[2]() { cmd_systemctl disable argo; [[ "$(systemctl is-active argo)" =~ 'inactive'|'unknown' ]] && info "\n Argo $(text 27) $(text 37)" || error " Argo $(text 27) $(text 38) "; } || ACTION[2]() { cmd_systemctl enable argo && [ "$(systemctl is-active argo)" = 'active' ] && info "\n Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "; }
    [[ ${STATUS[1]} = "$(text 28)" ]] && ACTION[3]() { cmd_systemctl disable sing-box; [[ "$(systemctl is-active sing-box)" =~ 'inactive'|'unknown' ]] && info "\n Sing-box $(text 27) $(text 37)" || error " Sing-box $(text 27) $(text 38) "; } || ACTION[3]() { cmd_systemctl enable sing-box && [ "$(systemctl is-active sing-box)" = 'active' ] && info "\n Sing-box $(text 28) $(text 37)" || error " Sing-box $(text 28) $(text 38) "; }
    ACTION[4]() { change_argo; exit; }
    ACTION[5]() { version; }
    ACTION[6]() { bash <(wget --no-check-certificate -qO- "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit; }
    ACTION[7]() { uninstall; exit 0; }
    ACTION[8]() { bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) -$L; exit; }
    ACTION[9]() { bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -$L; exit; }
    ACTION[10]() { bash <(wget --no-check-certificate -qO- https://tcp.hy2.sh/); exit; }

  else
    OPTION[1]="1.  $(text 34)"
    OPTION[2]="2.  $(text 32)"
    OPTION[3]="3.  $(text 51)"
    OPTION[4]="4.  $(text 58)"
    OPTION[5]="5.  $(text 64)"

    ACTION[1]() { install_sba; export_list; create_shortcut; exit; }
    ACTION[2]() { bash <(wget --no-check-certificate -qO- "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit; }
    ACTION[3]() { bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) -$L; exit; }
    ACTION[4]() { bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -$L; exit; }
    ACTION[5]() { bash <(wget --no-check-certificate -qO- https://tcp.hy2.sh/); exit; }
  fi

  [ "${#OPTION[@]}" -ge '10' ] && OPTION[0]="0 .  $(text 35)" || OPTION[0]="0.  $(text 35)"
  ACTION[0]() { exit; }
}

menu() {
  clear
  ### hint " $(text 2) "
  echo -e "======================================================================================================================\n"
  info " $(text 17):$VERSION\n $(text 18):$(text 1)\n $(text 19):\n\t $(text 20):$SYS\n\t $(text 21):$(uname -r)\n\t $(text 22):$SING_BOX_ARCH\n\t $(text 23):$VIRT "
  info "\t IPv4: $WAN4 $WARPSTATUS4 $COUNTRY4  $ASNORG4 "
  info "\t IPv6: $WAN6 $WARPSTATUS6 $COUNTRY6  $ASNORG6 "
  info "\t Argo: ${STATUS[0]}\t $ARGO_VERSION\t $AEGO_MEMORY\t $ARGO_CHECKHEALTH\n\t Sing-box: ${STATUS[1]}\t $SING_BOX_VERSION\t\t $SING_BOX_MEMORY\n\t Nginx: ${STATUS[0]}\t $NGINX_VERSION\t $NGINX_MEMORY "
  echo -e "\n======================================================================================================================\n"
  for ((b=1;b<${#OPTION[*]};b++)); do hint " ${OPTION[b]} "; done
  hint " ${OPTION[0]} "
  reading "\n $(text 24) " CHOOSE

  # 输入必须是数字且少于等于最大可选项
  if grep -qE "^[0-9]{1,2}$" <<< "$CHOOSE" && [ "$CHOOSE" -lt "${#OPTION[*]}" ]; then
    ACTION[$CHOOSE]
  else
    warning " $(text 36) [0-$((${#OPTION[*]}-1))] " && sleep 1 && menu
  fi
}

statistics_of_run-times

# 传参
[[ "${*,,}" =~ '-e' ]] && L=E
[[ "${*,,}" =~ '-c' ]] && L=C

while getopts ":AaSsUuNnTtVvBbFf:" OPTNAME; do
  case "${OPTNAME,,}" in
    a ) select_language; check_system_info; check_install; [ "${STATUS[0]}" = "$(text 28)" ] && { cmd_systemctl disable argo; [[ "$(systemctl is-active argo)" =~ 'inactive'|'unknown' ]] && info "\n Argo $(text 27) $(text 37)" || error " Argo $(text 27) $(text 38) "; } || { cmd_systemctl enable argo; [ "$(systemctl is-active argo)" = 'active' ] && info "\n Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "; } ;  exit 0 ;;
    s ) select_language; check_system_info; check_install; [ "${STATUS[1]}" = "$(text 28)" ] && { cmd_systemctl disable sing-box; [[ "$(systemctl is-active sing-box)" =~ 'inactive'|'unknown' ]] && info "\n Sing-box $(text 27) $(text 37)" || error " Sing-box $(text 27) $(text 38) "; } || { cmd_systemctl enable sing-box; [ "$(systemctl is-active sing-box)" = 'active' ] && info "\n Sing-box $(text 28) $(text 37)" || error " Sing-box $(text 28) $(text 38) "; } ;  exit 0 ;;
    u ) select_language; check_system_info; uninstall; exit 0 ;;
    n ) select_language; check_system_info; export_list; exit 0 ;;
    t ) select_language; change_argo; exit 0 ;;
    v ) select_language; check_arch; version; exit 0;;
    b ) select_language; bash <(wget --no-check-certificate -qO- "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit ;;
    f ) VARIABLE_FILE=$OPTARG; . $VARIABLE_FILE ;;
  esac
done

select_language
check_root
check_arch
check_system_info
check_dependencies
check_system_ip
check_install
menu_setting

[ -z "$VARIABLE_FILE" ] && menu || ACTION[1]
