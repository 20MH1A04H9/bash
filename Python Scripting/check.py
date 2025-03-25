#! /usr/bin/python3

age=input("what is your age? ")
money=input("Do you have any money RS:? ")

def alcholo(age, money):
    if (age>=21 and money>=100):
        return "You can drink alcohol"
    elif (age>=21 and money<100):
        return "You need more money to drink alcohol"
    else:
        return "Sorry, you are not old enough to drink alcohol"
print(alcholo(int(age), int(money)))
