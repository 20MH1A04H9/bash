#!/bin/bash

sum() {
  $(( $1 + $2 ))
}

subtract() {
  $(( $1 - $2 ))
}

multiply() {
  $(( $1 * $2 ))
}

echo -n "Enter first number: "
read num1
echo -n "Enter second number: "
read num2

echo "Sum: $(sum $num1 $num2)"
echo "Subtraction: $(subtract $num1 $num2)"
echo "Multiplication: $(multiply $num1 $num2)"