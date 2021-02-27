class Car{
    private String license;
    private Integer id;
    private Account driver;
    private Integer passenger;

    public Car(String license, Account driver){
        this.license = license;
        this.driver = driver;
        passenger = 4;
        System.out.println("passenger: " + passenger);
    }

    void printDataCar(){
        if(passenger != null){
            ystem.out.println("License: " + license + " Driver name: " + driver.name + " Passengers: " + passenger);
        }

    }

    public Integer getPassenger() {
        return passenger;
    }

    public void setPassenger(Integer passenger){
        if(passenger == 4) {
            this.passenger = passenger;
        }else{
            System.out.println("Necesitas asignar 4 pasajeros")
        }
    }

    public Integer getId(){
        return id;
    }

    public void setId(Integer id){
        this.id = id;
    }

    public String getLicense(){
        return license;
    }

    public void setLicense(String license){
        this.license = license;
    }

    public Account getDriver(){
        return driver;
    }

    public void setDriver(Account driver){
        this.driver = driver;
    }

}