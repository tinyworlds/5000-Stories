echo "5000 STORIES" > "5000_stories.txt"
echo "by Plot Narrator" >> "5000_stories.txt"
echo "Stories are being generated"

for (( i = 1; i <= 5000; i++ ))
do
ruby 5000_narrator.rb
echo "" >> "5000_stories.txt"
echo "$i/5000" >> "5000_stories.txt"
echo -ne "$i/5000 stories"\\r
done
echo "Done. Saved to 5000_stories.txt."
