<?php
require_once("car.php");
require_once("uberX.php");
require_once("uberPool.php")
require_once("account.php");

$uberX = new UberX("DSS789", new Account("Anahi Salgado", "ANN458"), "BMW", "M245i");
$uberX->printDataCar();

$uberPool = new UberPool("TYU456", new Account("Mauro Gom", "MAG756"), "Audi", "RS5")
$uberPool->printDataCar()

?>