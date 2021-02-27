from car import Car
from account import Account

if __name__== "__main__":
    print("Hola Mundo")
    """
    car = Car()
    car.license = "ANN321"
    car.driver = "Anahi Salgado"
    print(vars(car))

    car2 = Car()
    car2.license = "MAU777"
    car2.driver = "Mauro Gomez"
    print(vars(car2))
    """

    car = Car("ANN123", Account("Anahi Salgado", "AN465"))
    print(vars(car))
    print(vars(car.driver))