#include <assert.h>
int array1(int i)
{
    int a[] = {0, 1, 9};
    return a[i];
}

int array2(int i)
{
    int a[] = {0, 1, 2};
    int b = 3, c = 4;
    if (i <= 5 && i >= 0)
    {
        return a[i] + (a[i + 1] + 1) * a[i + 2];
    }
    else
    {
        return 0;
    }
}

int array3(int i)
{
    int a[5], b, c;
    a[4] = 100;
    return a[i];
}

int array4(int i)
{
    int a[] = {1, 2, 3, 4};
    int b[] = {1, 2, 3, 4, 5};
    assert(i > 0 && i < 4);
    return a[i] + b[i + 1];
}
