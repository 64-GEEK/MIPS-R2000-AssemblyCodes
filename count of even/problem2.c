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
    int list1[10] = {10,31,5,7,11,3,8,40,12,4};
    countOfEven(list1);
    
/////////////////////////////////////////////////////////////////////////////
    int list2[10] = {19,2,3,7,5,10,9,0,6,1};
    countOfEven(list2);
    
    return 0;
}