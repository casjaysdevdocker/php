#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202410090953-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  MIT
# @@ReadME           :
# @@Copyright        :  Copyright 2023 CasjaysDev
# @@Created          :  Mon Aug 28 06:48:42 PM EDT 2023
# @@File             :  06-post.sh
# @@Description      :  script to run post
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
php_ini=$(find /etc/php* -name 'php.ini' | grep -v '/etc/php$' | head -n1 | grep '^' || false)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Predifined actions
if [ -d "/etc/php/php-fpm" ]; then rm -Rf "/etc/php/php-fpm"; fi
if [ -d "/etc/php/php-fpm.d" ]; then rm -Rf "/etc/php/php-fpm.d"; fi
if [ -n "$php_ini" ]; then
  php_dir="$(dirname "$php_ini")"
  if [ $php_dir != "/etc/php" ]; then
    [ -L "/etc/php" ] || unlink /etc/php
    ln -sf "$php_dir" /etc/php
    [ -f "/etc/php.ini" ] && mv -f "/etc/php.ini" "/etc/php/php.ini"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main script

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
#exitCode=$?
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
exit $exitCode
