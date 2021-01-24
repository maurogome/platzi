# Intervalos de confianza

tamano_muestral <- 35
iteraciones <- 100
media_poblacional_A <- 5
media_poblacional_B <- 3
desv_est_poblacional <- 2

plot(media_poblacional_A, media_poblacional_B)

for(i in seq_len(iteraciones)){
  muestra_A <- rnorm(tamano_muestral, media_poblacional_A, desv_est_poblacional)
  t_test_A <- t.test(muestra_A)
  intervalo_A <- t_test_A$conf.int
  LI_A <- min(intervalo_A)
  LS_A <- max(intervalo_A)
  
  muestra_B <- rnorm(tamano_muestral, media_poblacional_B, desv_est_poblacional)
  t_test_B <- t.test(muestra_B)
  intervalo_B <- t_test_A$conf.int
  LI_B <- min(intervalo_B)
  LS_B <- max(intervalo_B)
  
  rect(LI_A, LI_B, LS_A, LS_B)
}

abline(0,1, col=2)

points(media_poblacional_A, media_poblacional_B, col = 4, pch = 20, cex = 3)

# ------------------------------------------------------------------------------

tamano_muestral <- 350
iteraciones <- 100
media_poblacional_A <- 5
media_poblacional_B <- 3
desv_est_poblacional <- 3
min_gr_A <- media_poblacional_A - 10*desv_est_poblacional/sqrt(tamano_muestral)
max_gr_A <- media_poblacional_A + 10*desv_est_poblacional/sqrt(tamano_muestral)
min_gr_B <- media_poblacional_B - 10*desv_est_poblacional/sqrt(tamano_muestral)
max_gr_B <- media_poblacional_B + 10*desv_est_poblacional/sqrt(tamano_muestral)

plot(media_poblacional_A, media_poblacional_B, xlim = c(min_gr_A, max_gr_A), ylim = c(min_gr_B, max_gr_B), col = 4, pch = 20)

for(i in seq_len(iteraciones)){
  muestra_A <- rnorm(tamano_muestral, media_poblacional_A, desv_est_poblacional)
  t_test_A <- t.test(muestra_A)
  intervalo_A <- t_test_A$conf.int
  LI_A <- min(intervalo_A)
  LS_A <- max(intervalo_A)
  
  muestra_B <- rnorm(tamano_muestral, media_poblacional_B, desv_est_poblacional)
  t_test_B <- t.test(muestra_B)
  intervalo_B <- t_test_B$conf.int
  LI_B <- min(intervalo_B)
  LS_B <- max(intervalo_B)
  
  rect(LI_A, LI_B, LS_A, LS_B)
  
}

abline(1,1, col = 2)
points(media_poblacional_A, media_poblacional_B, col = 4, pch = 20, cex = 3)