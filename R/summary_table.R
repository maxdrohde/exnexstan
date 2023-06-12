#' Create a gt HTML summary table from a fitted EXNEX model
#'
#' @param exnex_model A fitted EXNEX model
#'
#' @return A gt HTML table summarizing the model results
#' @export
#'
  summary_table <- function(exnex_model){

    exnex_model$summary() |>
      dplyr::filter(stringr::str_starts(.data[["variable"]], "p\\[")) |>
      dplyr::select(-c("ess_bulk", "ess_tail", "mad")) |>
      dplyr::select(`Strata Response Probability` = "variable",
             `Posterior Mean` = "mean",
             `Posterior Median` = "median",
             `Posterior SD` = "sd",
             `0.05 Quantile` = "q5",
             `0.95 Quantile` = "q95",
             `Rhat` = "rhat") |>
      gt::gt() |>
      gt::tab_header(
        title = "EXNEX Analysis Results",
      ) |>
      gt::fmt_percent(decimals = 1, columns = c(2,3,5,6)) |>
      gt::fmt_number(decimals = 2, columns = c(4,7)) |>
      gt::opt_interactive()
}
