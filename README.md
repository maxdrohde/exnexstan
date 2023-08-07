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

To use `exnexstan`, the `cmdstanr` R package and the `cmdstan` software must be installed, working and up-to-date before `exnexstan` is installed.

- `cmdstanr` can be installed via GitHub (see <https://mc-stan.org/cmdstanr/articles/cmdstanr.html>).
- `cmdstan` can be installed from within `cmdstanr` (see <https://mc-stan.org/cmdstanr/articles/cmdstanr.html#installing-cmdstan-1>).

If you already have `cmdstan` installed, run

```
cmdstanr::install_cmdstan(overwrite=TRUE)
```

within R to make sure it is up-to-date. There can be errors when installing `exnexstan` if your `cmdstan` installation is outdated.

## Vignettes

We provide two vignettes that demonstrate how to fit EXNEX models for binary data and count data with `exnexstan`.

- Binary data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_binary_vignette.html>
- Count data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_poisson_vignette.html>

For additional details on the functions, see the package documentation within R, or at the `pkgdown` site: <https://maxdrohde.github.io/exnexstan/>.

## References

For the mathematical details of EXNEX and more in-depth examples, see the [original paper](https://doi.org/10.1002/pst.1730) by Neuenschwander et al. (2015).

To view the Stan code used to implement these models, you can view them here: <https://github.com/maxdrohde/exnexstan/tree/master/inst>.

## Disclaimer

Unless otherwise stated, these programs are for research purposes only. We provide absolutely no warranty of any kind, either expressed or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose. The entire risk as to the quality and performance of these programs is with the user. Should any of these programs prove defective, the user assumes the cost of all necessary servicing, repair, or correction. In no event shall the creators of the software and this website be liable for damages, including any lost profits or other special, incidental or consequential damages arising out of the use of or inability to use these programs (including but not limited to loss of data or its analysis being rendered inaccurate or losses sustained by third parties).