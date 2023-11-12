int array1(int i)
{
    int a[] = {0, 1, 9};
    return a[i];
}

int array2(int i)
{
    int a[] = {0, 1, 2};
    int b = 3, c = 4;
    if (i <= 2 && i >= 0)
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

