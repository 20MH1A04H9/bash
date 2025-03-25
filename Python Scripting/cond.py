#! /usr/bin/python3
year=input("Enter the year: ")

if int(year) < 2024:
    print("past")

elif int(year) == 2024:
    print("Current")
else:
    print("Future")