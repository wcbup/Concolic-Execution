int sum(int a, int b, int c, int d, int e, int f, int g)
{
    return a + b + c + d + e + f + g;
}


int foo(int a)
{
    int b, c;
    b = 2;
    c = 3;
    c *= 7;
    b = b - 1;
    c = a / b * 77;
    c += sum(b, b, c, b, a, b, b);
    return a + b + c;
}

// int fib(int x)
// {
//     if (x <= 0)
//     {
//         return 0;
//     }
//     else if(x == 0)
//     {
//         return 1;
//     }
//     else
//     {
//         return fib(x - 1) + fib(x - 2);
//     }
// }