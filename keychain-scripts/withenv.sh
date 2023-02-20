#!/bin/bash

if [[ "$(uname)" = "Darwin" ]]; then
    STAT_FLAG="-f"
else
    STAT_FLAG="-c"
fi

# attempt to guess the root of the current project by looking for a .env
# file in all parent directories. If we can't fine one, just treat the CWD
# as the project root to match behavior of previous versions
find_root()
{
    local  orig_cwd
    orig_cwd="$( pwd -P)"
    local  cwd
    cwd="$orig_cwd"
    local  new_cwd
    new_cwd=""
    local  current_device_id
    current_device_id="$( stat $STAT_FLAG '%d' .)"

    while  true; do
        if     [[ -e "$cwd/.env" ]]; then
            echo        "$cwd"
            return        0
        else
            cd        ..
            new_cwd="$(       pwd -P)"
            if        [[ "$new_cwd" == "$cwd" ]]; then
                # don't search oncewe hit the root device
                break
            fi
            cwd="$new_cwd"
            if        [[ "$(stat $STAT_FLAG '%d' .)" != "$current_device_id" ]]; then
                # don't search if we cross a filesystem boundary
                break
            fi
        fi
    done

    # if we didn't find anything, just assume it's whatever directory we ran from.
    # ¯\_(ツ)_/¯
    echo  "$orig_cwd"
}

if [[ -n "${__IN_WITHENV__:-}" ]]; then
    orig_cwd="$( pwd -P)"
    cd  "$__WITHENV_SERVICEDIR__" || exit 1
    export  SERVICEDIR="$__WITHENV_SERVICEDIR__"
    for envfile in  $__ENVFILE__; do
        set     -a
        [[     -f "$envfile" ]] && . "$envfile"
        set     +a
    done
    export  PATH="${PATH:-"/usr/bin:/bin:/usr/local/bin"}"
    export  HOME="$__WITHENV_HOME__"
    export  TERM="$__WITHENV_TERM__"
    cd  "$orig_cwd" || exit 1
    unset  __IN_WITHENV__ __ENVFILE__ __WITHENV_HOME__ __WITHENV_TERM__ __WITHENV_SERVICEDIR__ STAT_FLAG orig_cwd envfile
    exec  "$@"
else
    READLINK="readlink"
    if  command -v greadlink > /dev/null 2>&1; then
        READLINK="greadlink"
    fi
    SERVICEDIR="$( find_root)"
    if  [[ $? -ne 0 ]]; then
        exit     1
    fi
    IN_WITHENV="$( $READLINK -e "$0")"
    ENVFILE="${ENVFILE:-".env .env-build .env-runtime .env-override .env-secrets"}"
    EXTRA_ENVFILES="${EXTRA_ENVFILES:-}"
    if  [[ -z "${HOME:-}" ]]; then
        HOME="$(    getent passwd "$(id -un)" | cut -d: -f 6)"
        if     [[ -z "$HOME" ]]; then
            echo        >&2 "Unable to determine \$HOME for $(id -un)"
            exit        1
        fi
    fi
    if  [[ -n "$EXTRA_ENVFILES" ]]; then
        ENVFILE="${ENVFILE} ${EXTRA_ENVFILES}"
    fi
    exec  env -i __IN_WITHENV__="$IN_WITHENV" __ENVFILE__="$ENVFILE" __WITHENV_HOME__="$HOME" __WITHENV_TERM__="$TERM" __WITHENV_SERVICEDIR__="$SERVICEDIR" "$IN_WITHENV" "$@"
fi
