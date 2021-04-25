def divisors(num):
    divisors = []
    for i in range(1, num + 1):
        if num % i == 0:
            divisors.append(i)

    return divisors

def run():

    num = input("Ingrese un número:")
    assert num.strip("-").isnumeric(), "Debes ingresar un numero"
    assert int(num) > 0, "El numero debe ser positivo"
    print(divisors(int(num)))
    print("Final del programa")



if __name__ == "__main__":
    run()