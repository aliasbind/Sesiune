#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

const long _NULL = 0;

struct node
{
    int info;
    struct node *left;
    struct node *right;
};

void insert(struct node **root, int key)
{
    if( (*root) == NULL)
    {
        *root = (struct node *) malloc(sizeof(struct node));
        (*root)->info = key;
        (*root)->left = NULL;
        (*root)->right = NULL;
    }
    else
    {
        if( (*root)->info < key)
        {
            insert( &((*root)->left), key);
        }
        else
        {
            insert( &((*root)->right), key);
        }
    }
}

void print(int pipe_fd[2], int level)
{
    struct node *current;
    size_t nread;
    int nodes_found = 0;

    while( (nread = read(pipe_fd[0], &current, sizeof(struct node *))))
    {
        nodes_found++;
        if(nread < 0)
            goto READFAILURE;

        if(current)
        {
            if(nodes_found == 1)
                printf("\nLevel %d: %d ", level, current->info);
            else
                printf("%d ", current->info);

            if(current->left)
                if(write(pipe_fd[1], &current->left, sizeof(struct node *)) < 0)
                    goto WRITEFAILURE;

            if(current->right)
                if(write(pipe_fd[1], &current->right, sizeof(struct node *)) < 0)
                    goto WRITEFAILURE;
        }
        else
        {
            write(pipe_fd[1], &_NULL, sizeof(struct node *));
            if(nodes_found != 1)
                print(pipe_fd, level+1);
            break;
        }
    }

    return;

WRITEFAILURE:
    perror("write");
    goto FAILURE;

READFAILURE:
    perror("read");
    goto FAILURE;

FAILURE:
    close(pipe_fd[0]);
    close(pipe_fd[1]);
    exit(EXIT_FAILURE);

}

int main(int argc, char *argv[])
{
    int pipe_fd[2];
    if( pipe(pipe_fd) < 0)
    {
        perror("pipe");
        return EXIT_FAILURE;
    }

    struct node *root = NULL;

    insert(&root, 30);
    insert(&root, 20);
    insert(&root, 40);
    insert(&root, 45);
    insert(&root, 15);

    if( write(pipe_fd[1], &root, sizeof(struct node *)) < 0)
        goto WRITEFAILURE;
    if( write(pipe_fd[1], &_NULL, sizeof(struct node *)) < 0)
        goto WRITEFAILURE;

    print(pipe_fd, 0);
    printf("\n\n");

    close(pipe_fd[0]);
    close(pipe_fd[1]);

    return EXIT_SUCCESS;

WRITEFAILURE:
    perror("write");
    close(pipe_fd[0]);
    close(pipe_fd[1]);
    return EXIT_FAILURE;
}
