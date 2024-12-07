
#include <stdio.h>

void countOfEven(int list[]){
int count = 0;
    int i = 0 ;
    for(i= 0 ; i < 10 ; i++){
        if (list[i]%2 == 0){
            count = count + 1 ;
        }
    }
   printf("Count of even numbers is: %d\n", count);
};


//////////////////////////////////////////////////////////////////////////////

int main() {
    int i = 0 ;
    int list[10];
    for(i= 0 ; i < 10 ; i++){
        int val ;
        scanf("%d", &val);
        list[i] = val;
    }
    //list1: 10,31,5,7,11,3,8,40,12,4
    countOfEven(list);
    return 0;
}