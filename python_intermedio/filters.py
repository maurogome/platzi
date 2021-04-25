def run():
    my_list = [1,2,4,5,6,8,9,20,21,23,24]
    odd = list(filter(lambda x: x % 2 != 0, my_list))
    print(odd)

if __name__ == "__main__":
    run()