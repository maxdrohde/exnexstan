# Purpose

# Installation

`exnexstan` is not on CRAN but can be installed from GitHub using the `install_github()` function from the `devtools` package.

```{r}
install.packages("devtools") # Skip if devtools already installed
devtools::install_github(repo = "https://github.com/maxdrohde/exnexstan")
```

To use `exnexstan`, the `cmdstanr` package must be installed and working. For details on installing `cmdstanr`, see <https://mc-stan.org/cmdstanr/articles/cmdstanr.html>.

# Vignettes

We provide two vignettes that explain the use of `exnexstan` to fit EXNEX models for binary data and count data.

- Binary data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_binary_vignette.html>
- Count data: <https://maxdrohde.github.io/exnexstan/vignettes/exnex_poisson_vignette.html>

