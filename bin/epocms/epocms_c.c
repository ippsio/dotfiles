#include <stdio.h>
#include <sys/time.h>

int main(void) {
  struct timeval _time;
  gettimeofday(&_time, NULL);
  long sec = _time.tv_sec;
  long milli_sec = _time.tv_usec/1000;
  printf("%ld%03ld\n", sec, milli_sec);
  return 0;
}

