#include <stdio.h>
#include <stdlib.h>

#include <signal.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>

int ORIGINAL_STDIN;

void start_forking(int argc, char *argv[], char *env[], int carg)
{
    int pipe_fd[2];
    pid_t child;
    char *newargv[] = {NULL, NULL};

    if(carg > 0)
    {
        if(pipe(pipe_fd) < 0)
        {
            perror("pipe");
            exit(EXIT_FAILURE);
        }

        if(dup2(pipe_fd[0], STDIN_FILENO) < 0)
        {
            perror("dup2");
            close(pipe_fd[0]);
            close(pipe_fd[1]);
            exit(EXIT_FAILURE);
        }

        child = fork();

        if(child < 0)
        {
            perror("fork");
            exit(EXIT_FAILURE);
        }

        if(child == 0)
        {
            if(dup2(pipe_fd[1], STDOUT_FILENO) < 0)
            {
                perror("dup2");
                close(pipe_fd[0]);
                close(pipe_fd[1]);
                exit(EXIT_FAILURE);
            }

            start_forking(argc, argv, env, carg-1);
        }
        close(pipe_fd[1]);
        wait(NULL);
    }
    else
    {
        if(dup2(ORIGINAL_STDIN, STDIN_FILENO) < 0)
        {
            perror("dup2");
            exit(EXIT_FAILURE);
        }
    }

    newargv[0] = argv[carg];
    execve(argv[carg], newargv, env);
    perror("execve");
}

int main(int argc, char *argv[], char *env[])
{
    if(argc < 2)
    {
        printf("Usage: %s f1 .. fn\n", argv[0]);
        exit(EXIT_SUCCESS);
    }

    ORIGINAL_STDIN = dup(STDIN_FILENO);
    start_forking(argc, argv, env, argc-1);
    return EXIT_FAILURE;
}
