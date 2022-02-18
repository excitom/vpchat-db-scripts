/*
 * Function: Run the a command, passing through input arguments. This
 * program runs with setUID privilege. This is intended to be run
 * from a CGI program.
 *
 * Tom Lang 12/97
 */
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

main(int argc, char **argv) {
        setuid(geteuid());
        if (errno) {
                perror("Couldn't set uid");
                exit(1);
        }
#ifdef DEBUG
FILE *s = fopen("/logs/x", "a+");
fprintf(s, "uid %d euid%d\n", getuid(), geteuid());
fclose (s);
#endif
        execv("/usr/bin/kill", argv);
        perror("exec kill failed");
}
