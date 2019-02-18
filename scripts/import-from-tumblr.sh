for F in $(ls -1 ../posts/ | grep .md ) ;
do
  POSTID=${F%.md}
#for POSTID in $(xmllint --xpath "//post/@id" ../posts/posts.xml  | egrep -o "[0-9]+") ;
#do
  NEWFN=$(date --date="$(xmllint --xpath "string(tumblr/posts/post[@id=$POSTID]/@date)" ../posts/posts.xml )" +%Y-%m-%d-$POSTID.md)
  TITLE=$(xmllint --xpath "string(tumblr/posts/post[@id=$POSTID]/regular-title)" ../posts/posts.xml)
  ( echo -e "---\nlayout: post\ntitle: \"${TITLE:-Today}\"\nauthor: fabiand\n---\n\n" ; [[ -n "$TITLE" ]]  && sed "/${TITLE//\//\\\/}/,+1 d" ../posts/$F || cat ../posts/$F ) > ../_posts/$NEWFN
done
