def run():
    #squares = [i**2 for i in range(1,101) if i%3 != 0]
    #print(squares)

    my_list = [i for i in range(1,10000) if (i % 4 == 0 and i % 6 == 0 and i % 9 == 0)]
    print(my_list)

if __name__ == "__main__":
    run()