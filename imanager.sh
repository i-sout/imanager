#!/bin/sh

# script path
script_path=$(cd `dirname $0`; pwd)
script_name=`basename $0`
raw_input_file="$0"

cur_path="$script_path/.`date +%s%N`"
xml_name="imanager.xml"

prepare() {
    mkdir $cur_path
}

destroy() {
    rm -rf $cur_path
}

get_config() {
    xml="$script_path/$xml_name"
    if [ ! -s $xml ]; then
        echo "Error: $xml not exist or is empty."
        exit 1
    fi


    if [ ! $1 ]; then
        echo "Error: missing config config_name."
        exit 1
    fi
    config_name=$1

    file=$cur_path/$config_name.sh

    start=`grep -n "^<$config_name>\$" $xml | awk -F: '{print $1}' | tail -n 1`
    end=`grep -n "^</$config_name>\$" $xml | awk -F: '{print $1}' | tail -n 1`

    if [ "$start" = "" -o "$end" = "" ];then
        echo "Error: invalid config config_name '$config_name'."
        exit 1
    fi

    if [ $start -gt $end ];then
        echo "Error: invalid $xml_name."
        exit 1
    fi

    head -n `expr $end - 1` $xml | tail -n `expr $end - $start - 1 ` > $file
    config_file=$file
}

run_config()
{
    config_name=$1
    get_config $config_name
    . $config_file
    # echo "$?"
}


install() {
    echo "installing..."
    run_config "before_install"
    run_config "install"
    run_config "after_install"
    echo "install finished."
}

help() {
    echo "Usage: "
    echo "    $raw_input_file install/uninstall/start/stop/reload/restart..."
    exit 1
}

if [ ! $1 ]; then
    help
fi
func=$1

prepare
run_config "application"
$func
destroy