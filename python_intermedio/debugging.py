def divisors(num):
    divisors = []
    for i in range(1, num + 1):
        if num % i == 0:
            divisors.append(i)

    return divisors

def run():

    try:
        num = int(input("Dame un numero: "))

        if num < 0:
            raise Exception("Numeros negativo")
        else:
            print(divisors(num))
            print("Final del programa")

    except ValueError:
        print("Debes ingresar un numero, intenta de nuevo...")
        run()

    except Exception:
        print("El numero que ingresaste debe ser positivo, intenta de nuevo...")
        run()

if __name__ == "__main__":
    run()