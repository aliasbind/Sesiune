#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

//Verificarea corectitudinii argumentelor
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

//Baga un intreg (el) intr-un vector (buf)
void add_to_int_buf(int **buf, int *buf_len, int el)
{
    int i;
    int *new_buf = malloc( (sizeof(int) * (*buf_len)) + 1);
    for(i=0; i<*buf_len; i++)
    {
        new_buf[i] = (*buf)[i];
    }
    new_buf[*buf_len] = el;
    free(*buf);
    *buf = new_buf;
    *buf_len = *buf_len + 1;
}

//Citeste un intreg char cu char si-l compune intr-un int.
int read_an_int(int fd)
{
    char buf;
    int bytes_rd;
    int sgn = 1;
    int result = 0;
    char prev_ch = 0;
    while((bytes_rd = read(fd, &buf, 1)) >= 0)
    {
        if(buf == '-')
        {
            sgn = -1;
        }
        if(buf <= '9' && buf >= '0')
        {
            result = (result * 10) + (buf - 48);    
        }    
        if((buf == ' ' || buf == '\n' || buf == 10 ||
          bytes_rd == 0) && (prev_ch >= '0' && prev_ch <= '9'))
        {
            return result * sgn;
        }
        if(buf == 0 || bytes_rd == 0)
        {
            errno = 127;
            return -1;
        }
        prev_ch = buf;
    }
}

//"Comparatorul" pentru functia qsort (folosita in main).
int compare(const void *a, const void *b)
{
    return *((int *) a) - *((int *) b);
}

//Scrie un array intr-un fisier.
void write_int_array_to_file(int *buf, int buf_len, int fd)
{
    off_t seek_st;
    if( (seek_st = lseek(fd, 0, SEEK_SET)) < 0 )
    {
        perror("error");
        exit(1);
    }
    else
    {
        char *num;
        int i;
        num = malloc(sizeof(char) * 10);
        for(i=0; i<buf_len; i++)
        {
            sprintf(num, "%d", buf[i]);
            write(fd, num, strlen(num));
            if(i < buf_len-1)
                write(fd, " ", 1);
        }
        free(num);
    }
}

int main(int argc, char *argv[])
{
    if(test_args(argc, argv) < 0)
    {
        printf("Usage: %s file\n", argv[0]);
        return 0;
    }
    else
    {
        int fd = open(argv[1], O_RDWR);
        int an_int;
        int *buf = NULL;
        int buf_len = 0;
        while( ((an_int = read_an_int(fd)) != -1) || errno != 127)
        {
            add_to_int_buf(&buf, &buf_len, an_int);
        }
        qsort(buf, buf_len, sizeof(int), compare);
        write_int_array_to_file(buf, buf_len, fd);
    }
    return 0;
}
