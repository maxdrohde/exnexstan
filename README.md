# Purpose

The `exnexstan` package provides a user-friendly interface to fitting EXNEX models in R without interfacing with a probabilistic programming languages like BUGS, JAGS, or Stan.

# Installation

`exnexstan` is not on CRAN but can be installed from GitHub using the `install_github()` function from the `devtools` package.

```
# Skip if devtools is already installed
install.packages("devtools")

devtools::install_github(repo = "https://github.com/maxdrohde/exnexstan")
```

To use `exnexstan`, the `cmdstanr` package must be installed and working. For details on installing `cmdstanr`, see <https://mc-stan.org/cmdstanr/articles/cmdstanr.html>.

# Vignettes

We provide two vignettes that describe how to fit EXNEX models for binary data and count data with `exnexstan`.

- Binary data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_binary_vignette.html>
- Count data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_poisson_vignette.html>

For additional details on the functions, see the package documentation within R, or at the `pkgdown` site: <https://maxdrohde.github.io/exnexstan/>.

# References

For the mathematical details of EXNEX, see the [original paper](https://doi.org/10.1002/pst.1730) by Neuenschwander et al. (2016). `exnexstan` uses the Stan probabilistic programming language for model fitting -- further details can be found at <https://mc-stan.org/>.
