#' Fit an EXNEX model
#'
#' @param n An integer vector with the number of observations per strata
#' @param r An integer vector with the number of "successes" per strata
#' @param p_exch A numeric vector specifying the prior on the exchangeability proportion for each strata
#' @param seed Set seed for the random number generated
#' @param chains Number of MCMC chains to run
#' @param parallel_chains Number of cores to use for running chains in parallel
#' @param iter_warmup Number of warmup iterations
#' @param iter_sampling Number of sampling iterations
#' @param adapt_delta Tuning parameter for MCMC sampling
#' @param ... Other parameters to be passed into the `sample` function of cmdstanr
#'
#' @examples
#' \dontrun{
#' # Example data from Table 1 of Neuenschwander et al.
#' fit_exnex(r = c(2, 0, 1, 6, 7, 3, 5, 1, 0, 3) |> as.integer(),
#'           n = c(15, 13, 12, 28, 29, 29, 26, 5, 2, 20) |> as.integer(),
#'           p_exch = rep(0.5, 10),
#'           adapt_delta = 0.99)
#' }
#'
#' @return A fitted cmdstanr model
#' @export
#'
fit_exnex <- function(n,
                      r,
                      p_exch,
                      seed = 123456789,
                      chains = 4,
                      parallel_chains = 4,
                      iter_warmup = 3000,
                      iter_sampling = 5000,
                      adapt_delta = 0.9,
                      ...){

  # Data checking
  if(!length(unique(lengths(list(r, n, p_exch)))) == 1L)
    stop("Error: r, n, and p_exch must have the same length")
  if(!all(is.integer(n), is.integer(r)))
    stop("Error: r and n must be integer vectors")
  if(!is.numeric(p_exch))
    stop("Error: p_exch must be a numeric vector")

  # Format data for Stan
  data_list <-
    list(r = as.integer(r),
         n = as.integer(n),
         p_exch = p_exch,
         J = length(n))

  # Get the path to the Stan executable file
  # The files are stored in the `inst` folder when developing the package
  # and are copied to the user's computer when installed. system.file() is
  # used to locate the file after installation.
  # See here for details: https://r-pkgs.org/misc.html#sec-misc-inst
  exe <- system.file("exnex", package = "exnexstan")

  # Read in the Stan executable file
  mod <- cmdstanr::cmdstan_model(exe_file = exe)

  # Fit the model with cmdstanr
  fit <- mod$sample(
    data = data_list,
    seed = seed,
    chains = chains,
    parallel_chains = parallel_chains,
    iter_warmup = iter_warmup,
    iter_sampling = iter_sampling,
    adapt_delta = adapt_delta,
    ...
  )

  return(fit)
}
