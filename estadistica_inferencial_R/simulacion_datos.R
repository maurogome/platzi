# Distribucion nrmal estandar

Y <- rnorm(100)

plot(density(Y))

#Distribucion normal de media cinco y desviacion estandar 3

Y <- rnorm(100, 5, 5)

plot(density(Y))

# Distribucion uniforme 0, 1

Y <- runif(100)

plot(density(Y))

# Distribucion uniforme a = 3, b = 8

Y <- runif(100, 3, 8)

plot(density(Y))

#Ejemplo de la edad y el lugar

data.frame(
  Edad = rnorm(50, 10, 1.2),
  Lugara = "Escuela"
) -> escuela

data.frame(
  Edad = rnorm(45, 15, 1.9),
  Lugara = "Preparatoria"
) -> prepa

data.frame(
  Edad = rnorm(80, 21, 2.5),
  Lugara = "Universidad"
) -> universidad

rbind(escuela, prepa, universidad) -> edad_lugar

boxplot(Edad ~ Lugara, data = edad_lugar)

# Modelo lineal

X <- seq(0,3*pi, length.out = 100)
Y <- -0.3*X + 1 + rnorm(100, 0, 0.5)
Z <- -0.3*X + 1

data.frame(X,Y,Z) -> datos_lineal

plot(Y ~ X, data = datos_lineal)

lines(Z ~ X, data = datos_lineal, col = 2, lwd = 2)


# Modelo No Lineal

X <- seq(0,3*pi, length.out = 100)
Y <- cos(X) + rnorm(100, 0, 0.5)
Z <- cos(X)

data.frame(X,Y,Z) -> datos_no_lineal

plot(Y ~ X, data = datos_no_lineal)

lines(Z ~ X, data = datos_no_lineal, col = 2, lwd = 2)






















