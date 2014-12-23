# run rfcdiff on changes to a file between branches.
# syntax: aodiff <branch1> <branch2> <file>

#branch=$(git branch | grep "\* .*master")
branch1=$1
branch2=$2
file=$3 #todo: split at /, take last
git show $branch1:./$file > $branch1.txt
git show $branch2:./$file > $branch2.txt
echo "running rfcdiff..."
rfcdiff $branch1.txt $branch2.txt 
rm $branch1.txt $branch2.txt
echo "done."
