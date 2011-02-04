#include <errno.h>
#include <dirent.h>
#include <fcntl.h>
#include <sys/types.h>

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include <unistd.h>

char *get_last_file(char *path)
{
    int path_len = strlen(path);
    int i;
    for(i=path_len-1; i>=0; i--)
        if(path[i] == '/')
            break;
    if(i == 0 && path[i] != '/')
        return NULL;

    int slash_pos = i;
    int filename_size = path_len - i;
    char *filename = (char *) malloc(sizeof(char) * filename_size);

    filename[filename_size-1] = '\0';
    for(i=0; i<filename_size; i++)
    {
        filename[i] = path[slash_pos + i + 1];
    }
    return filename;
}

void list_tree(char *cpath, int level)
{
    DIR *cdir = NULL;
    if( (cdir = opendir(cpath)) == NULL)
    {
        switch(errno)
        {
            case ENOTDIR:
                break;
            
            case ENOENT:
                break;

            case EACCES:
                break;

            default:
                perror(cpath);
                exit(1);
        }
    }
    else
    {
        struct dirent *data_cdir = NULL;
        while( (data_cdir = readdir(cdir)) != NULL)
        {
            if(strcmp(data_cdir->d_name, ".") == 0 || strcmp(data_cdir->d_name, "..") == 0)
                continue;

            int i;
            for(i=0; i<level; i++)
                printf("|  ");

            printf("%s\n", data_cdir->d_name);

            int d_name_len = strlen(data_cdir->d_name);
            char *newpath = (char *) malloc(sizeof(char) * (strlen(cpath) + d_name_len + 2));

            strcpy(newpath, cpath);
            if(strcmp(cpath, "/"))
                strcat(newpath, "/");
            strcat(newpath, data_cdir->d_name);
            
            list_tree(newpath, level+1);
            free(newpath);
        }
        closedir(cdir);
    }
}

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        printf("Usage: %s directory-path\n", argv[0]);
        return 0;
    }
    list_tree(argv[1], 0);
    return 0;
}
