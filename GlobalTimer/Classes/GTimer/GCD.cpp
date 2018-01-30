//
//  GCD.cpp
//  GlobalTimer
//
//  Created by Steve on 30/01/2018.
//

#include "GCD.hpp"
using namespace std;

// C++ program to find GCD of two or
// more numbers


// Function to return gcd of a and b
int gcd(int a, int b)
{
    if (a == 0)
        return b;
    return gcd(b%a, a);
}

// Function to find gcd of array of
// numbers
int findGCD(int arr[], int n)
{
    int result = arr[0];
    for (int i=1; i<n; i++)
        result = gcd(arr[i], result);
    
    return result;
}

