#!/bin/bash

sum() {
  echo -n $(( $1 + $2 ))
}

subtract() {
  echo -n $(( $1 - $2 ))
}

multiply() {
  echo -n $(( $1 * $2 ))
}

echo -n "Enter first number: "
read num1
echo -n "Enter second number: "
read num2

echo "Sum: $(sum $num1 $num2)"
echo "Subtraction: $(subtract $num1 $num2)"
echo "Multiplication: $(multiply $num1 $num2)"