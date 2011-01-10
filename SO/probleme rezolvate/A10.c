#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

int test_args(int argc, char *argv[])
{
    int fd;
    if(argc != 2)
        return -1;
   
    if((fd = open(argv[1], O_RDWR)) < 0)
    {
        perror(argv[1]);
        exit(1);
    }
    close(fd);
    return 0;
}

int get_file_contents(int fd, int *fc_len)
{
    char *str;
    struct stat file_prop;
    int shmid;

    if(fstat(fd, &file_prop) < 0)
    {
        perror("");
        exit(1);
    }
    else
    {
        *fc_len = file_prop.st_size;
        
        //Aloc memorie partajata doar intre toate procesele ce se 
        //forkuiesc din procesul initial (IPC_PRIVATE) de marime *fc_len
        //(marimea fisierului).

        //Pentru info suplimentare vedeti "man shmget"
        if((shmid = shmget(IPC_PRIVATE, *fc_len, IPC_CREAT | 0666)) < 0)
        {
            perror("shmget");
            exit(1);
        }
        else
        {
            str = shmat(shmid, NULL, 0); //"Montez" memoria partajata
        }

        int i;
        char buf;
        for(i=0; i<*fc_len; i++)
        {
            if(read(fd, &buf, 1) < 0)
            {
                perror("");
                shmdt(str);    //"Demontez" memoria partajata
                shmctl(shmid, IPC_RMID, NULL); //Dezaloc (eliberez) memoria partajata
                exit(1);
            }
            else
            {
                str[i] = buf;
            }
        }
        shmdt(str);
        return shmid;
    }
}

void merge(int shmid, int start1, int end1, int start2, int end2)
{
    int i, j, temp_count=0;
    int temp_size = sizeof(char) * (end1-start1) + (end2-start2) + 2;
    char *temp = (char *) malloc(temp_size);
    char *str;
    i = start1;
    j = start2;

    str = shmat(shmid, NULL, 0);

    while(i <= end1 || j <= end2)
    {
        if(i <= end1 && j <= end2)
        {
            if(str[i] <= str[j])
            {
                temp[temp_count++] = str[i];
                i++;
            }
            else
            {
                temp[temp_count++] = str[j];
                j++;
            }
        }
        else
        {
            if(i <= end1)
            {
                temp[temp_count++] = str[i];
                i++;
            }
            else
            {
                temp[temp_count++] = str[j];
                j++;
            }
        }
    }

    for(i=0; i<temp_count; i++)
    {
        str[start1+i] = temp[i];
    }
    free(temp);
    shmdt(str);
    exit(0);
}

void merge_sort(int shmid, int left, int right)
{
    if(right - left > 0)
    {
        int m = (left+right) / 2;

        if(!fork())
            merge_sort(shmid, left, m);
               
        if(!fork())
            merge_sort(shmid, m+1, right);
        
        wait(NULL);
        wait(NULL);
        
        merge(shmid, left, m, m+1, right);
        exit(0);
    }
}

int main(int argc, char *argv[])
{
    if(test_args(argc, argv) == -1)
    {
        printf("Usage: A10 file\n");
        return 0;
    }

    int fd = open(argv[1], O_RDWR);
    char *file_contents;
    int fc_len;
    int shmid;
    int i;
    
    shmid = get_file_contents(fd, &fc_len);

    file_contents = shmat(shmid, NULL, 0);
    printf("Unsorted:");
    for(i=0; i<fc_len; i++)
    {
        if(!(i % 16))
            printf("\n");
        printf("%02X ", file_contents[i]);
    }
    printf("\n");
    shmdt(file_contents);

    if(!fork())
        merge_sort(shmid, 0, fc_len-1);
    wait(NULL);

    file_contents = shmat(shmid, NULL, 0);
    printf("\nSorted:");
    for(i=0; i<fc_len; i++)
    {
        if(!(i % 16))
            printf("\n");
        printf("%02X ", file_contents[i]);
    }
    printf("\nTotal size: %d\n", fc_len);
    shmctl(shmid, IPC_RMID, NULL);
    shmdt(file_contents);

    return 0;
}
