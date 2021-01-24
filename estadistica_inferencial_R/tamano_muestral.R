# Distribución Normal

tamano_muestral_max <- 5000
iteraciones <- 1000
media_poblacional <- 5
desv_est <- 3
tamano_muestral <- floor(seq(10, tamano_muestral_max, length.out = iteraciones))

desv_est_estimada <- media_estimada <- dif_cuad_media <- dif_cuad_desv_est <- vector()

for(i in seq_len(iteraciones)){
  muestra <- rnorm(tamano_muestral[i], media_poblacional, desv_est_poblacional)
  media_estimada[i] <- mean(muestra)
  desv_est_estimada[i] <- sd(muestra)
  dif_cuad_media[i] <- (media_poblacional - media_estimada[i])^2
  dif_cuad_desv_est[i] <- (desv_est_poblacional - desv_est_estimada[i])^2
}

plot(media_estimada ~ tamano_muestral)
abline(h = media_poblacional, col = 2, lwd = 2)

plot(dif_cuad_media ~ tamano_muestral)


plot(desv_est_estimada ~ tamano_muestral)
abline(h = desv_est_poblacional, col = 2, lwd = 2)

plot(dif_cuad_desv_est ~ tamano_muestral)