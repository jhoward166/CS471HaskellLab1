> module Lab1
>	where

Define factorial. Let Haskell infer the type of factorial.

> factorial n =if n== 0 then 1 else n * factorial (n - 1)
> fact1 :: Int -> Int
> fact1 n = if n==0 then 1 else n* fact1 (n - 1)
> fact2 :: Integer -> Integer
> fact2 n = if n == 0 then 1 else n * fact2 (n - 1)
> factP :: Integer -> Integer
> factP 0 = 1
> factP n = n * factP(n-1)
> factG x
>   | x < 0		= error "neg n"
>   | x == 0	= 1
>	| otherwise	= x * factG(x - 1)
> factG2 :: Integer -> Integer
> factG2 n
>     | n < 0     = error "neg n"
>     | n == 0    = 1
>     | otherwise = n * factG2 (n - 1)
> factE :: Integer -> Integer
> factE n
>     | n < 0     = error "neg n"
>     | n == 0    = 1
>     | otherwise = n * factE n - 1

Tuple Data Type

> sumT (a,b,c) = a + b + c

Curried Function

> sumC a b c = a + b + c
> sumCx :: Num a => a -> (a -> (a->a))
> sumCx a b c = a + b + c 
> sumC1  = sumC 1
> sumC2  = sumC1 2
> sumC3  = sumC2 3
> sumC12 = sumC 1 2

Joseph Howard (jhoward4)
CS 471 Programming Languages
Eileen Head
11/13/2014

Part 2
Question 3

fact2 is defined as an Integer which must have static size in memory which limits the size of the number that may be stored there. When the value gets too high bit overflow will cause wrong outputs.

fact1 is of type Integer which seems to restrict the input to an integer, but allows the bounds of this integer in memory to expand. When the space becomes too small for the data being stored there it must change the type to int long and reallocate the value in memory.

factorial can be literally any type. As the value is computed haskell picks the value best suited to the output and uses that to interpret the data.

Question 4

The program returns a stack overflow error for the input Lab1> factorial (-2). Our interpretation of factorial does not handle negative numbers and there is no base case to stop the recursion. The program tries to calculate the factorial of decrementing negative values until the stack overflows.

The program returns a cannot infer instance error. Because the -2 is not encapsulated with () the call is interpreted as minus 2 and another argument is expected. Factorial is interpreting the data being passed to it as "minus 2" and it is expecting a number.

There is one definition. When the input (-2) is entered the program returns "Program error: neg n"

Question 7

factorial 5.1 returns a stack overflow. Again because the code never hits it's base case it will cause a stack overflow. Because the input is an decimal it will never hit 1 or 0, it will simply just keep calculating the factorial of x-1 until it runs out of memory space.

factG 5.1 returns the negative number error. Though it does not hangle decimals, it will catch the error when the number attempts to execute the first recursive call that is less than 0. Instead of filling the stack the recursive call executes until it breaks this check case.

factG2 5.1 returns a cannot infer reference error. At the beginning of factG2 we define its acceptable input and output. The function should take in an integer and return an integer. Any other input, in this case a fractional, will return an error.

factG2 encapsulates the input for the recursive call with (), while factE does not. What ends up being executed in the first call of factE is 5 * factE(5) - 1. The value of n is increasing instead of decreasing. Our base case is therefore never met, but the number will never go negative and therefore factE iterates until the stack overflow error is thrown.

Part 3
Question 1

Tuple Data Type

The infered type of sumT is Num a => (a,a,a) -> a

Question 2

The infered type of sumC is Num a => a -> a -> a -> a

Question 3

The infered type of sumCx is Num a => a -> a -> a -> a. This is the same as Part 3 Question 2 and it appears that Haskell executes left to right

Question 4

I think that this is legal. (If it was illegal that wouldn't really be showing off the features of Haskell) sumC12 will be X + 1 + 2, sumC3 will be 6, sumC2 = X + 1 + 2, sumC1 = X + Y + 1. I was correct. The code uses partially evaluated functions which is a feature of Haskell.

Question 5

There is no way to do this same style of coding for sumT. None of the given definitions were legal.

Question 6

F G H = F ( G H) Haskell executes with right associativity.

Question 7
	a) h(x) = ((3 * x + 1) * 2) * 2 - 5
	b) h2(x) = 3 * (x * 2 - 5) + 1
	c) 23 = 28 - 5 = 7 * 2 * 2 - 5 = ((3 * 2 + 1) * 2) * 2 - 5 
	d) -2 = (-3) + 1 = 3 * (-1) + 1 = 3 * ( 2 * 2 - 5) + 1
