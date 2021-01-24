#install.packages("caret")
#install.packages("nnet")
#install.packages("parallel")

library("lattice")
library("ggplot2")
library("caret")
library("nnet")
library("parallel")

# Funcion de pliegue ------------------------------------------------------

rmse_fold <- function(pliegue, form, datos, nn_size){
  pliegue_logic <- seq_len(nrow(datos)) %in% pliegue
  entrena <- subset(datos, !pliegue_logic)
  prueba <- subset(datos, pliegue_logic)
  modelo <- nnet(form, data = entrena, size = nn_size, lineout = TRUE, trace = FALSE)
  response_name <- setdiff(names(datos), modelo$coefnames)
  Y_pronosticado <- predict(modelo, newdata = prueba)
  rmse <- RMSE(Y_pronosticado, prueba[[response_name]])
  rmse
}

# Modelo no lineal --------------------------------------------------------

n_pliegues <- 7
tamano_muestral <- 300
neuronas <- 10

genera_y <- function(x){
  cos(x) + rnorm(length(x), 0, 0.5)
}

X <- seq(0, 3*pi, length.out = tamano_muestral)
Y <- genera_y(X)

data.frame(X, Y) -> muestra


# Validacion cruzada ------------------------------------------------------

createFolds(muestra$Y, k = n_pliegues) -> pliegues

mclapply(
  pliegues,
  rmse_fold,
  Y ~ X,
  muestra,
  nn_size = neuronas
) -> rmse_pliegues

rmse_pliegues <- unlist(rmse_pliegues)
mean(rmse_pliegues)

plot(rmse_pliegues, ylim = c(0,1))
abline(h = mean(rmse_pliegues), col = 2, lwd = 4)























