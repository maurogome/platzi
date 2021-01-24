#install.packages("nnet")
library("nnet")

# Red neuronal -----------------------------------------------------------------

iteraciones <- 150
tamano_muestral <- 200

genera_y <- function(x){
  cos(x) + rnorm(length(x), 0, 0.5)
}

X <- seq(0, 3*pi, length.out = tamano_muestral)
Y <- genera_y(X)

plot(Y ~ X)
lines(cos(X) ~ X, col = 2, lwd = 2)

red_neuronal <- nnet(X, Y, size = 6, linout = TRUE, trace = FALSE)

YY <- predict(red_neuronal)

lines(YY ~ X, col = 4, lwd = 2)

# Simulacion ------------------------------------------------------------

plot(Y ~ X)

for(i in seq_len(iteraciones)){
  Y <- genera_y(X)
  red_neuronal <- nnet(X, Y, size = 6, linout = TRUE, trace = FALSE)
  YY <- predict(red_neuronal)
  lines(YY ~ X, col = 4, lwd = 2)
}


lines(cos(X) ~ X, col = 2, lwd = 2)


























