# library(devtools)
# install()

library(exnexstan)

fit <-
fit_exnex(r = c(2,0,1,6,7,3,5,1,0,3) |> as.integer(),
          n = c(15, 13, 12, 28, 29, 29, 26, 5, 2, 20) |> as.integer(),
          p_exch = rep(0.5, 10),
          adapt_delta = 0.99)

summary_table(fit)
