#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202410090953-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  MIT
# @@ReadME           :
# @@Copyright        :  Copyright 2023 CasjaysDev
# @@Created          :  Mon Aug 28 06:48:42 PM EDT 2023
# @@File             :  05-custom.sh
# @@Description      :  script to run custom
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2031
# shellcheck disable=SC2120
# shellcheck disable=SC2155
# shellcheck disable=SC2199
# shellcheck disable=SC2317
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
set -o pipefail
[ "$DEBUGGER" = "on" ] && echo "Enabling debugging" && set -x$DEBUGGER_OPTIONS
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set env variables
exitCode=0
BIN_DIR="/usr/local/bin"
DOWNLOAD_LINK="https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions"
EXT_ADDITIONAL="@composer @fix_letsencrypt"
EXT_INSTALLED="$([ -n "$(type -P 'php')" ] && php -m | awk '{print $1}' | grep -Fv '[' | grep -v '^$' | tr '[:upper:]' '[:lower:]')"
EXT_LIST="bcmath bz2 calendar cgi common ctype curl dba dom enchant exif ffi fileinfo fpm ftp gd gettext gmp iconv imap intl ldap litespeed mbstring mysqli mysqlnd odbc opcache openssl pcntl pdo pdo_dblib pdo_mysql pdo_odbc "
EXT_LIST+="pdo_pgsql pdo_sqlite pear pgsql phar phpdbg posix pspell session shmop simplexml snmp soap sockets sodium sqlite3 sysvmsg sysvsem sysvshm tidy tokenizer xml xmlreader xmlwriter xsl zip memcached mcrypt mongodb redis xdebug"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Predifined actions
[ -d "$BIN_DIR" ] || mkdir -p "$BIN_DIR"
if [ -n "$EXT_INSTALLED" ]; then
  if curl -q -sSLf "$DOWNLOAD_LINK" -o "$BIN_DIR/install-php-extensions"; then
    chmod +x "$BIN_DIR/install-php-extensions"
    for ext in $EXT_LIST $EXT_ADDITIONAL; do
      if ! echo "$ext" | grep -q "$EXT_INSTALLED"; then
        if apk add --no-cache php-$ext || install-php-extensions $ext; then
          echo "Installed $ext"
        else
          echo "Failed to install $ext" >&2
        fi
      fi
    done
  else
    echo "Failed to install $BIN_DIR/install-php-extensions" >&2
    exitCode=1
  fi
else
  echo "Can not get php modules: is php installed?"
  exitCode=2
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main script
php -m
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
#exitCode=$?
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
exit $exitCode
