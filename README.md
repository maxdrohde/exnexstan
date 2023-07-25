## Overview

The `exnexstan` package provides a user-friendly interface to fitting EXNEX models in R without requiring the user to directly interface with a probabilistic programming language like BUGS, JAGS, or Stan.

Stan (<https://mc-stan.org/>) is used to fit the models using modern Hamiltonian Markov Chain Monte Carlo (HMC) sampling.

## Installation

The `exnexstan` package is not on CRAN, but can be installed from GitHub using the `install_github()` function from the `devtools` package.

```
# Skip if devtools is already installed
install.packages("devtools")

devtools::install_github(repo = "https://github.com/maxdrohde/exnexstan")
```

To use `exnexstan`, the `cmdstanr` R package and the `cmdstan` software must be installed and working.

- `cmdstanr` can be installed via GitHub (see <https://mc-stan.org/cmdstanr/articles/cmdstanr.html>).
- `cmdstan` can be installed from within `cmdstanr` (see <https://mc-stan.org/cmdstanr/articles/cmdstanr.html#installing-cmdstan-1>).

## Vignettes

We provide two vignettes that demonstrate how to fit EXNEX models for binary data and count data with `exnexstan`.

- Binary data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_binary_vignette.html>
- Count data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_poisson_vignette.html>

For additional details on the functions, see the package documentation within R, or at the `pkgdown` site: <https://maxdrohde.github.io/exnexstan/>.

## References

For the mathematical details of EXNEX and more in-depth examples, see the [original paper](https://doi.org/10.1002/pst.1730) by Neuenschwander et al. (2016).
