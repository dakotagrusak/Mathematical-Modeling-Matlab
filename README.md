
# Mathematical Modeling with MATLAB

Work from the course Mathematical Modeling at Trinity University. Taught by Dr. Nguyen in the Fall of 2018.

This was an excellent course that explored the theory and implementation of various mathematical modeling techniques and strategies. In the course we implemented optimization techniques on single and multivariable models. We modeled financial situations, biological phenomena and interactions, theory from physics and engineering. 

All in all, I enjoyed the class imensely and after revisiting the material and delving deeper into machine learning I have come to realize that it has provided a strong launching point for more advances statistical and algorithmic phenomena.

## 1.1

__Conditional Statements__
Write a program that accepts a numerical variable *x* from 0 to 100 and displays the corresponding letter grade give by the table below

| Letter Grade | Score Range |
|---|--------|
| A | 90-100 |
| B | 80-89  |
| C | 70-79  |
| D | 60-69  |
| F | <= 59  |

## 1.2

__Loop Control Statements__
Find how long it will take to accumulate at least 10,000 dollars in a bank account if you deposit 500 dollars initially and $\$ 500 at the end of each year, if the account pays 10% annual interest.

## 1.3

__Least Squares Regression__
To determine which function base (e or 2) is a better function to approximate the rabbit population (generated from the Fibonacci sequence), *implement percent errors to determine which base returns a closer approximation to the actual rabbit population at month 21*. Include your implementation in the code downloaded from Tlearn and use comments to justify your answers.

    - percentError(base_e, fib)

    - percentError(base_2, fib)

## 2.1

__Unconstrained Optimization (One Variable)__
A pig weighing 200 pounds gains 5 pounds per day and costs 4 cents a day to keep. The market price for pigs is 65 cents per pound, but is falling 1 cent per day. When should the pig be sold?
    1. Build the model to describe the profit from the sale of the pig
    2. Find the optimal profit to decide the best time to sell the pig using the derivative test. Implement your solving procedure using Matlab Symbolic Toolbox. Also plot a graph of the profit.
    3. Use the "fminunc()" function.
    4. Examine the sensitivity of the optimal profit to our assumption of the growth rate 5 lbs/day of the pig.

## 3.1

__Unconstrained Optimization (Multivariable)__
A manufacturer of lawn furniture makes two types of lawn chairs, one with a wood frame and one with a tubular aluminum frame. The wood-frame model costs 18 dollars per unit to manufacture, and the aluminum-frame model costs 10 dollars per unit. The company operates in a market where the number of units that can be sold depends on the price. It is estimated that in order to sell x units per day of the wood-frame model and y units per day of the aluminum-frame model, the selling price cannot exceed 10+31x−0.5+1.3y−0.2 dollars/unit for wood-frame chairs, and 5+15y^(−0.4)+0.8x^(−0.08) dollars/unit for aluminum-frame chairs. Find the optimal production levels.

*Notice that the objective function f(x, y) tends to infinity as x  or y  approaches zero, and that f(x, y ) is undefined on the lines x  = 0 and y  = 0 that form the boundary of the feasible region.*

    1. Build the model to describe the profit function.
    2. Decide the quantity of each type by finding the maximum profit. Implement the Second Derivative test as well as plot a surface graph and contour plot of the profit.
    3. Use the "fminunc()" function.
    4. Determine the sensitivity of the maximum profit to the costs of the wood-frame model and the aluminum-frame model.
