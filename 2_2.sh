grep -in 'session="asdfadfasas3432423ewd3da"' file.txt | awk -F: '
{
command=sprintf("sed -n '%s,/%s/p' ./file.txt | grep -c Balance", $1, "\\<\\\\/R")
command|getline x
if (x !~ 0) 
{
    command=sprintf("sed -n '%s,%sp' ./file.txt", $1-2, $1-1)
    system(command)
    command=sprintf("sed -n '%s,/%s/p' ./file.txt", $1, "\\<\\\\/R")
    system(command)
}
}
'