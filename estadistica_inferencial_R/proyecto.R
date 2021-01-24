install.packages("devtools")
devtools::install_github("nebulae-co/saber")

library("saber")


# cargar datos ------------------------------------------------------------

data("SB11_20112")

iteraciones <- 38
tamano_muestral <- 27

plot(
  mean(SB11_20112$MATEMATICAS_PUNT),
  sd(SB11_20112$MATEMATICAS_PUNT),
  pch = 20, cex = 4, col = "white"
)

for(i in seq_len(iteraciones)){
  points(
    mean(sample(SB11_20112$MATEMATICAS_PUNT, tamano_muestral)),
    sd(sample(SB11_20112$MATEMATICAS_PUNT, tamano_muestral)),
    pch = 20
  )
}

points(
  mean(sample(SB11_20112$MATEMATICAS_PUNT)),
  sd(sample(SB11_20112$MATEMATICAS_PUNT)),
  pch = 20, cex = 4, col = 2
)


# Intervalo de confianza --------------------------------------------------

table(SB11_20112$ECON_SN_INTERNET)

tamano_muestral <- 3000
iteraciones <- 100

poblacion_A <- SB11_20112$FISICA_PUNT[SB11_20112$ECON_SN_INTERNET == 0]
media_poblacional_A <- mean(poblacion_A, na.rm = TRUE)

poblacion_B<- SB11_20112$FISICA_PUNT[SB11_20112$ECON_SN_INTERNET == 1]
media_poblacional_B <- mean(poblacion_B, na.rm = TRUE)

plot(media_poblacional_A, media_poblacional_B, col = 4, pch = 20)
abline(0, 1)

for(i in seq_len(iteraciones)){
  muestra <- sample(seq_len(nrow(SB11_20112)), tamano_muestral)
  
  cuales_A <- seq_len(nrow(SB11_20112)) %in% muestra & SB11_20112$ECON_SN_INTERNET == 0
  muestra_A <- SB11_20112$FISICA_PUNT[cuales_A]
  
  media_muestral_A <- mean(muestra_A, na.rm = TRUE)
  t_test_A <- t.test(muestra_A)
  intervalo_A <- t_test_A$conf.int
  LI_A <- min(intervalo_A)
  LS_A <- max(intervalo_A)
  
  cuales_B <- seq_len(nrow(SB11_20112)) %in% muestra & SB11_20112$ECON_SN_INTERNET == 1
  muestra_B <- SB11_20112$FISICA_PUNT[cuales_B]
  
  media_muestral_B <- mean(muestra_B, na.rm = TRUE)
  t_test_B <- t.test(muestra_B)
  intervalo_B <- t_test_B$conf.int
  LI_B <- min(intervalo_B)
  LS_B <- max(intervalo_B)
  
  rect(LI_A, LI_B, LS_A, LS_B)
}

points(media_poblacional_A, media_poblacional_B, col = 4, pch = 20, cex = 4)


# Red neuronal de pronostico con datos reales -----------------------------

library("nnet")

tamano_muestral <- 2000

c(
  "ECON_PERSONAS_HOGAR",
  "ECON_CUARTOS",
  "ECON_SN_LAVADORA",
  "ECON_SN_NEVERA",
  "ECON_SN_HORNO",
  "ECON_SN_DVD",
  "ECON_SN_MICROHONDAS",
  "ECON_SN_AUTOMOVIL",
  "MATEMATICAS_PUNT"
) -> variables

indices_muestra <- seq_len(nrow(SB11_20112)) %in% sample(seq_len(nrow(SB11_20112)), tamano_muestral)

muestra <- subset(SB11_20112, subset = indices_muestra, select = variables)
muestra <- na.omit(muestra)

red_neuronal <- nnet(MATEMATICAS_PUNT ~ ., data = muestra, size = 10, linout = TRUE)

plot(muestra$MATEMATICAS_PUNT ~ predict(red_neuronal))
abline(0, 1, lwd = 2, col = 2)


# Validacion cruzada ------------------------------------------------------

library("caret")
library("parallel")


# Funcion de pliegue

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

# Red Neuronal

tamano_muestral <- 5000
neuronas <- 10
n_pliegues <- 10

indices_muestra <- seq_len(nrow(SB11_20112)) %in% sample(seq_len(nrow(SB11_20112)), tamano_muestral)

muestra <- subset(SB11_20112, subset = indices_muestra, select = variables)
muestra <- na.omit(muestra)

createFolds(muestra$MATEMATICAS_PUNT, k = n_pliegues) -> pliegues

mclapply(
  pliegues,
  rmse_fold,
  MATEMATICAS_PUNT ~.,
  muestra,
  nn_size = neuronas
) -> rmse_pliegues

rmse_pliegues <- unlist(rmse_pliegues)
mean(rmse_pliegues)

plot(rmse_pliegues, ylim = c(40, 50))
abline(h = mean(rmse_pliegues), col = 2, lwd = 2)

# -------------------------------------------------------------------------
# Calculando el tamaño optimo de la muestra -------------------------------
# -------------------------------------------------------------------------

# función de pliegue

rmse_fold <- function(pliegue, form, datos,  nn_size){
  pliegue_logic <- seq_len(nrow(datos)) %in% pliegue
  entrena <- subset(datos, !pliegue_logic)
  prueba <- subset(datos, pliegue_logic)
  modelo <- nnet(form, data = datos, size = nn_size, linout = TRUE, trace = FALSE)
  response_name <- setdiff(names(datos), modelo$coefnames)
  Y_pronosticado <- predict(modelo, newdata = prueba)
  rmse <- RMSE(Y_pronosticado, prueba[[response_name]])
  rmse
}

calcula_rmse_tam <-function(tamano_muestral){
  indices_muestra <- seq_len(nrow(SB11_20112)) %in% sample(seq_len(nrow(SB11_20112)), tamano_muestral)
  
  muestra <- subset(SB11_20112, subset = indices_muestra, select = variables)
  muestra <- na.omit(muestra)
  
  createFolds(muestra$MATEMATICAS_PUNT, k = n_pliegues) -> pliegues
  
  lapply(
    pliegues,
    rmse_fold, 
    MATEMATICAS_PUNT ~., 
    muestra, 
    nn_size = neuronas 
  ) -> rmse_pliegues
  mean(unlist(rmse_pliegues))
}

tamano_muestral_max <- 10000
iteraciones <- 20
tamano_muestral <- floor(seq(500, tamano_muestral_max, length.out = iteraciones))
n_pliegues <- 4
neuronas <- 20


c(
  "ECON_PERSONAS_HOGAR",
  "ECON_CUARTOS",
  "ECON_SN_LAVADORA",
  "ECON_SN_NEVERA",
  "ECON_SN_HORNO",
  "ECON_SN_DVD",
  "ECON_SN_MICROHONDAS",
  "ECON_SN_AUTOMOVIL",
  "MATEMATICAS_PUNT"
) -> variables

mclapply(
  tamano_muestral,
  calcula_rmse_tam
) -> rmse_por_tam

rmse_por_tam <- unlist(rmse_por_tam)

plot(tamano_muestral, rmse_por_tam, ylim = c(0, 14))


# Contextualizacion de la NN ----------------------------------------------

# Interpretación

tamano_muestral <- 5000

indices_muestra <- seq_len(nrow(SB11_20112)) %in% sample(seq_len(nrow(SB11_20112)), tamano_muestral)

muestra <- subset(SB11_20112, subset = indices_muestra, select = variables)
muestra <- na.omit(muestra)

red_neuronal <- nnet(MATEMATICAS_PUNT ~ ., data = muestra, size = neuronas, linout = TRUE)

predict(red_neuronal, newdata = SB11_20112) -> puntaje_pronosticado

nuevo_puntaje_mat <- SB11_20112$MATEMATICAS_PUNT - puntaje_pronosticado
nuevo_puntaje_mat <- na.omit(nuevo_puntaje_mat)

plot(density(nuevo_puntaje_mat))







































