#/bin/bash

# This will go through a repo history and replace
# username and email with a new username and email
# in the logs.  This is handy if someone commits
# and pushes without having their user.name and
# user.email set.


if [ -z ${1} ] || [ -z ${2} ] || [ -z ${3} ] || [ -z ${4} ];
then
  echo
  echo "Usage: ${0} 'Old Username' 'Old E-mail' 'New Username' 'New Email'"
  echo
fi

exit 1

git filter-branch --env-filter '
      if [ "$GIT_AUTHOR_EMAIL" = "${2}" ];
      then
          export GIT_AUTHOR_EMAIL="${4}";
      fi
      if [ "$GIT_COMMITTER_EMAIL" = "${2}" ];
      then
          export GIT_COMMITTER_EMAIL="${4}";
      fi
      if [ "$GIT_AUTHOR_NAME" = "${1}" ];
      then
          export GIT_AUTHOR_NAME="${3}"
      fi
      if [ "$GIT_COMMITTER_NAME" = "${1}" ];
      then
          export GIT_COMMITTER_NAME="${3}"
      fi
      ' HEAD
