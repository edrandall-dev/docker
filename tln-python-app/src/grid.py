
def table():
    while True:
        try:
            x = int(input("Please enter a number: "))
            for row in range(1, x+1):
                for col in range(1, x+1):
                    print(f"{row*col:3}", end = " ")
                print() 

        except ValueError:
            print("No, Please Enter a Number!")
        q = input("Do you want to do another table? y/n ").lower()
        if q[0] == "n":
            break
table()