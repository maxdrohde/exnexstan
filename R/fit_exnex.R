#' Fit an EXNEX model with Stan
#'
#' @param n An integer vector with the number of observations per strata
#' @param r An integer vector with the number of "successes" per strata
#' @param p_exch A numeric vector specifying the prior probability of exchangeability for each strata
#' @param mu_prior_mean Mean for the normal prior set on mu.
#' @param mu_prior_sd Standard deviation for the normal prior set on mu.
#' @param tau_prior_mean Mean for the normal prior set on tau.
#' Tau has a lower bound of zero so any probability mass below zero will be reallocated.
#' Setting `tau_prior_mu = 0` and `tau_prior_sd = 1` is equivalent to a standard
#' half-normal distribution.
#' @param tau_prior_sd Standard deviation for the normal prior set on tau.
#' Tau has a lower bound of zero, so setting `tau_prior_mu = 0` and `tau_prior_sd = 1` is equivalent to a standard
#' half-normal distribution.
#' @param nex_prior_mean Mean for the normal prior set on the non-exchangeable distributions.
#' @param nex_prior_sd Standard deviation for the normal prior set on the non-exchangeable distributions.
#' @param seed Set seed for the random number generated
#' @param chains Number of MCMC chains to run
#' @param parallel_chains Number of cores to use for running chains in parallel
#' @param iter_warmup Number of warmup iterations
#' @param iter_sampling Number of sampling iterations
#' @param adapt_delta Tuning parameter for MCMC sampling
#' @param ... Other parameters to be passed into the sample function of cmdstanr
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
#' @section MCMC convergence issues:
#' When `p_exch` is set close to 1, there can be convergence issues
#' due to the funnel-like geometry that arises when \eqn{\tau} is close to zero.
#' See the [exnexstan::fit_exch()] function, which can fix convergence issue using
#' a non-centered parameterization of the model for the special case of `p_exch = 1`.
#'
#' @return A fitted cmdstanr model
#' @export
#'
#'
fit_exnex <- function(n,
                      r,
                      p_exch,
                      mu_prior_mean = -1.73,
                      mu_prior_sd = 2.616,
                      tau_prior_mean = 0,
                      tau_prior_sd = 1,
                      nex_prior_mean = -1.73,
                      nex_prior_sd = 2.801,
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
    list(
      r = r,
      n = n,
      p_exch = p_exch,
      J = length(n),
      mu_prior_mean = mu_prior_mean,
      mu_prior_sd = mu_prior_sd,
      tau_prior_mean = tau_prior_mean,
      tau_prior_sd = tau_prior_sd,
      nex_prior_mean = nex_prior_mean,
      nex_prior_sd = nex_prior_sd
    )

  # Read in the Stan executable file
  mod <- stan_package_model(name = "exnex", package = "exnexstan")

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
