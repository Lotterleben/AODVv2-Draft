# rfcdiff files between branches.
branch=$(git branch | grep "\* .*master")
if [[ $branch == *"master"* ]]; then
	echo "Error: You're on the master branch. Please change to the branch that you want to compare against the master version (using git checkout) and run this command again."
else
	git show master:./$1 > master.txt
	echo "executing: rfcdiff master.txt "$1
	rfcdiff master.txt $1
	rm master.txt
	echo "done."
fi
