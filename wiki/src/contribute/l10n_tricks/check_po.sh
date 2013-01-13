#!/bin/sh
# -*- mode: sh; sh-basic-offset: 4; indent-tabs-mode: nil; -*-
# vim: set filetype=sh sw=4 sts=4 expandtab autoindent:

if ! [ -x "`which i18nspector`" ] ; then
  echo "i18nspector: command not found"
  echo "You need to install i18nspector first. See /contribute/l10n_tricks."
  exit
fi

PATTERNS_FILE="$(mktemp -t XXXXXX.patterns)"
echo "
boilerplate-in-language-team
boilerplate-in-last-translator
boilerplate-in-project-id-version
invalid-date
invalid-language
invalid-last-translator
language-team-equal-to-last-translator
no-language-header-field
no-package-name-in-project-id-version
no-report-msgid-bugs-to-header-field
no-version-in-project-id-version
unable-to-determine-language
unknown-poedit-language
" | grep -v '^$' > $PATTERNS_FILE

find -iname "*.po" -exec i18nspector '{}' \; | grep -v -f $PATTERNS_FILE
