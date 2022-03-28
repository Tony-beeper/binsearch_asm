
#include <stdio.h>
#include <stdlib.h>


int recurs(int arr[], int x, int n){
    //x->val
    //n->size
    if(n==0) return -1;
    if(x == arr[n/2]){
        return n/2;
    }
    else if(arr[n/2] > x){
        //go right arr[n/2 : len(arr)]
        int index = n/2 + 1;
        int size = n - n/2 -1;
        int sol = recurs(&arr[index], x, size);
        if(sol == -1) return -1;
        return (n/2 + 1 + sol);
        


    }else if(arr[n/2] < x){
        // go left arr[0: n/2]
        return recurs(arr, x, n/2);
        
    }

    return -1;

}


int main(){
    int arr[6] = {7,6,5,4,3, 2};
    printf("sol: %d\n", recurs(arr, 0, 6));

}