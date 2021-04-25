def run():
    my_dict = {i:i**3 for i in range(1,101) if i % 3 != 0}
    print(my_dict)

    sec_dict = {i:i**0.5 for i in range(1,1001)}
    print(sec_dict)

if __name__ == "__main__":
    run()