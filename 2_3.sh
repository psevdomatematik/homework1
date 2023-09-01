grep -in '<Response' file.txt | awk -F: '
{
    command=sprintf("sed -n '%s,/%s/p' ./file.txt | grep -c Withdrawal", $1, "\\<\\\\/R")
    command|getline x
    if (x !~ 0) {
        command=sprintf("sed -n '%s,/%s/p' ./file.txt | grep -c code", $1, "\\<\\\\/R")
        command|getline x
        if (x !~ 0) {
            command=sprintf("sed -n '%s,/%s/p' ./file.txt | grep -c %s", $1, "\\<\\\\/R", "code\\>0000")
            command|getline x
            if (x == 0) {
                command=sprintf("sed -n '%s,%sp' ./file.txt", $1-2, $1-1)
                system(command)
                command=sprintf("sed -n '%s,/%s/p' ./file.txt", $1, "\\<\\\\/R")
                system(command)
            }
        } else 
        {
            command=sprintf("sed -n '%s,%sp' ./file.txt", $1-2, $1-1)
            system(command)
            command=sprintf("sed -n '%s,/%s/p' ./file.txt", $1, "\\<\\\\/R")
            system(command)
        }
    }
}
'