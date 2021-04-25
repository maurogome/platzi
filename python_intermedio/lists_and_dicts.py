def run():
    #my_list = [1, True, "Que onda", 3.5]
    #my_dict = {"first_name": "Mauricio", "last_name": "Gomez"}

    super_list = [
        {"first_name": "Mauricio", "last_name": "Gomez"},
        {"first_name": "Maria", "last_name": "Gonzalez"},
        {"first_name": "Jose", "last_name": "Arango"},
        {"first_name": "Sara", "last_name": "Mejia"},
    ]

    super_dict = {
        "natural_nums": [1,2,3,4,5],
        "integer_nums": [-1,1,0,2],
        "floating_nums": [0.5, -0.5, 4.3, 1.8],
    }

    for key, value in super_dict.items():
        print(key, "-", value)

    for value in super_list:
        print(value)

    squares = []

    for  i in range(1,101):
        if i**2 % 3:
            squares.append(i**2)

    print(squares)

if __name__ == "__main__":
    run()