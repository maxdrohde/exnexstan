data {
  int<lower=1> J; // Number of trial strata
  array[J] int n; // Number of subjects per strata
  array[J] int r; // Number of successes per strata

  // User set parameters for the priors
  real mu_prior_mean;
  real mu_prior_sd;
  real tau_prior_mean;
  real tau_prior_sd;
}
parameters {
  real mu;             // Mean of hierarchical log-odds distribution 
  real<lower=0> tau;   // SD of hierarchical log-odds distribution 
  vector[J] theta_std; // Log-odds of response for each strata (standardized for non-centered parameterization)
}
model {
  for (j in 1:J) {                                  // Loop over the trial strata
    theta_std[j] ~ normal(mu, 1);                   // Hierarchical structure + use non-centered parameterization
    r[j] ~ binomial_logit(n[j], theta_std[j]*tau);  // Binomial likelihood with built-in expit transform
  }
  // Priors
  mu ~ normal(mu_prior_mean, mu_prior_sd);    
  tau ~ normal(tau_prior_mean, tau_prior_sd);    // Half-normal prior because of the constraint
}
generated quantities {
   // Convert from log-odds space to probability space
   vector[J] p;
   p = inv_logit(theta_std*tau);
}










