var=$(grep -i 'type' 'file.txt' | sed 's/type//g' | sed 's/[<>/]//g')
used=''
for v in $var
do
    if [[ "$used" != *"$v"* ]]; then
        used="$used$v"
        count=$(grep -c $v file.txt)
        echo "$used: $count"
    fi
done
