#' Fit an EXNEX model for count data with varying follow-up time with Stan
#'
#' @param t A numeric vector with the follow-up time per strata
#' @param r An integer vector with the number of events per strata
#' @param p_exch A numeric vector specifying the prior probability of exchangeability for each strata
#' @param mu_prior_mean Mean for the normal prior set on mu.
#' @param mu_prior_sd Standard deviation for the normal prior set on mu.
#' @param tau_lower_bound Lower bound for the tau parameter. Any probability mass below that will be reallocated.
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
#' fit_exnex_varying_time(
#'   r = rep(5, 10) |> as.integer(),
#'   t = seq(5, 50, length.out=10),
#'   p_exch = rep(0.5, 10),
#'   adapt_delta = 0.99
#' )
#' }
#'
#' @section MCMC convergence issues:
#' When `p_exch` is set close to 1, there can be convergence issues
#' due to the funnel-like geometry that arises when \eqn{\tau} is close to zero.
#' Setting the lower bound for tau to a small positive number can help with this.
#'
#' @return A fitted cmdstanr model
#' @export
#'
#'
fit_exnex_varying_time <- function(t,
                                   r,
                                   p_exch,
                                   mu_prior_mean = -1.73,
                                   mu_prior_sd = 2.616,
                                   tau_lower_bound = 0,
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
                                   ...) {
  # Data checking
  if (!length(unique(lengths(list(r, t, p_exch)))) == 1L) {
    stop("Error: r, t, and p_exch must have the same length")
  }
  if (!is.integer(r)) {
    stop("Error: r must be an integer vector")
  }
  if (!is.numeric(p_exch)) {
    stop("Error: p_exch must be a numeric vector")
  }
  if (tau_lower_bound < 0) {
    stop("Error: tau_lower_bound must be non-negative")
  }

  # Format data for Stan
  data_list <-
    list(
      t = t,
      r = r,
      p_exch = p_exch,
      J = length(t),
      mu_prior_mean = mu_prior_mean,
      mu_prior_sd = mu_prior_sd,
      tau_lower_bound = tau_lower_bound,
      tau_prior_mean = tau_prior_mean,
      tau_prior_sd = tau_prior_sd,
      nex_prior_mean = nex_prior_mean,
      nex_prior_sd = nex_prior_sd
    )

  # Get the path to the Stan executable file
  # The files are stored in the `inst` folder when developing the package
  # and are copied to the user's computer when installed. fs::path_package() is
  # used to locate the file after installation.
  # See here for details: https://r-pkgs.org/misc.html#sec-misc-inst
  exe <- fs::path_package("exnexstan", "exnex_varying_time")

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
