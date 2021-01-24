# Distribucion uniforme

tamano_muestral <- 70000
a <- 3
b <- 8
iteraciones <- 100

x <- seq(2, 9, length.out = 100)

Y <- runif(tamano_muestral, a, b)

estimador_kernel <- density(Y)

plot(estimador_kernel)
lines(x, dunif(x, a, b), col = 2, lwd = 2)

plot(estimador_kernel)

for(i in seq_len(iteraciones)){
  Y <- runif(tamano_muestral, a, b)
  estimador_kernel <- density(Y)
  lines(estimador_kernel)
}

lines(x, dunif(x, a, b), col = 2, lwd = 2)

# Distribucion acomulada empirica

tamano_muestral <- 70
a <- 3
b <- 8
iteraciones <- 100

x <- seq(2, 9, length.out = 100)

Y <- runif(tamano_muestral, a, b)

estimador_ecdf <- ecdf(Y)

plot(estimador_ecdf, pch = "", verticals = TRUE)
lines(x, punif(x, a, b), col = 2, lwd = 2)

for(i in seq_len(iteraciones)){
  Y <- runif(tamano_muestral, a, b)
  estimador_ecdf <- ecdf(Y)
  lines(estimador_ecdf, pch = "", verticals = TRUE)
}


lines(x, punif(x, a, b), col = 2, lwd = 2)














