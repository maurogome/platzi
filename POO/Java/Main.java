class Main {
    public static void main(String[] args) {
        System.out.println("Hola Mundo!");

        UberX uberX = new UberX("ANN123", new Account("Anahi Salgado", "AN123"), "Volkswagen", "Jetta");
        uberX.setPassenger(4);
        uberX.printDataCar();

        UberVan uberVan = new UberVan("MAG777", new Account("Mauro Gome", "MG645"))
        uberVan.setPassenger(6);
        uberVan.printDataCar();
    }
}