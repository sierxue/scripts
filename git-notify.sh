#!/usr/bin/env bash
# https://raw.githubusercontent.com/jakeonrails/git-notify/2a323308232e74883e070162efffac693dfec6f5/git-notify

function run {
# how we want to extract the variables from the commit message.
format_name="--format=%cn"
format_date="--format=%at"
format_when="--format=%cr"
format_summary="--format=%s"
format_body="--format=%b"

# what repository do we want to watch (default to origin/master)
if [ -z "$1" ]; then
	repository="origin/master"
else
	repository="$1"
fi
latest_revision="none"

# loop forever, need to kill the process.
while [ 1 ]; do

    # get the latest revision SHA.
    current_revision=`git rev-parse $repository`

    # if we haven't seen that one yet, then we know there's new stuff.
    if [ $latest_revision != $current_revision ]; then

        # mark the newest revision as seen.
        latest_revision=$current_revision

        # extract the details from the log.
        commit_name=`git log -1 $format_name $latest_revision`
        commit_date=`git log -1 $format_date $latest_revision`
        commit_when=`git log -1 $format_when $latest_revision`
        commit_summary=`git log -1 $format_summary $latest_revision`
        commit_body=`git log -1 $format_body $latest_revision`

        # notify the user of the commit.
        repo=$(basename $(pwd))
        now=$(date +%s)
        diff=$(( $now - $commit_date ))
        # ganx: 259200 = 3 * 24 * 60 * 60, i.e., three days.
        if [ "$diff" -lt 259200 ]; then
            # If repository="origin/master", then it does not display.)
            if [ "$repository="origin/master"" ]; then
                # notify the user of the commit.
                summary="$commit_name committed to $repo $commit_when!"
                body="$commit_summary\n\n$commit_body"
            else
                # notify the user of the commit.
                summary="$commit_name committed to $repo \
                    $repository $commit_when!"
                body="$commit_summary\n\n$commit_body"
            fi
        fi
	if [ "`uname`" == "Darwin" ]
	then
		command="osascript -e 'display notification \"$body\" with title \"$summary\"'"
		eval $command
	else
	        `notify-send "$summary" "$body"` 
	fi

    fi
    sleep 60
done
}

if git rev-parse --git-dir > /dev/null 2>&1; then
	(run $1 &)
else
	echo "Error: not a git repository"
fi
