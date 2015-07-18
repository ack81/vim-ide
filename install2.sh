#!/bin/bash

major_version=
os=
host=

get_hostname ()
curl_check ()
{
  echo "Checking for curl..."
  if command -v curl > /dev/null; then
    echo "Detected curl..."
  else
    echo "Installing curl..."
    yum install -d0 -e0 -y curl
  fi
}

unknown_os ()
{
  echo "This is an unknown operating system"
  exit 1
}

if [ -e /etc/os-release ]; then
  . /etc/os-release
  major_version=`echo ${VERSION_ID} | awk -F '.' '{ print $1 }'`
  os=${ID}

elif [ `which lsb_release 2>/dev/null` ]; then
  # get major version (e.g. '5' or '6')
  major_version=`lsb_release -r | cut -f2 | awk -F '.' '{ print $1 }'`

  # get os (e.g. 'centos', 'redhatenterpriseserver', etc)
  os=`lsb_release -i | cut -f2 | awk '{ print tolower($1) }'`

elif [ -e /etc/oracle-release ]; then
  major_version=`cut -f5 --delimiter=' ' /etc/oracle-release | awk -F '.' '{ print $1 }'`
  os='ol'

elif [ -e /etc/fedora-release ]; then
  major_version=`cut -f3 --delimiter=' ' /etc/fedora-release`
  os='fedora'

elif [ -e /etc/redhat-release ]; then
  os_hint=`cat /etc/redhat-release  | awk '{ print tolower($1) }'`
  if [ "${os_hint}" = "centos" ]; then
    major_version=`cat /etc/redhat-release | awk '{ print $3 }' | awk -F '.' '{ print $1 }'`
    os='centos'
  elif [ "${os_hint}" = "scientific" ]; then
    major_version=`cat /etc/redhat-release | awk '{ print $4 }' | awk -F '.' '{ print $1 }'`
    os='scientific'
  else
    major_version=`cat /etc/redhat-release  | awk '{ print tolower($7) }' | cut -f1 --delimiter='.'`
    os='redhatenterpriseserver'
  fi

else
  aws=`grep -q Amazon /etc/issue`
  if [ "$?" = "0" ]; then
    major_version='6'
    os='aws'
  else
    unknown_os
  fi
fi

if [[ ( -z "${os}" ) || ( -z "${major_version}" ) || ( "${os}" = "opensuse" ) ]]; then
  unknown_os
fi

echo "Detected ${os} version ${major_version}... "

curl_check

curl -f "${yum_repo_config_url}" > $yum_repo_path
curl_exit_code=$?

