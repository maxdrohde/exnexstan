data {
  int<lower=1> J; // Number of trial strata
  array[J] int n; // Number of subjects per strata
  array[J] int r; // Number of successes per strata
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
  mu ~ normal(-1.73, 2.616);     // Centered at logit(0.15)
  tau ~ normal(0, 1);            // Half-normal prior because of the constraint
}
generated quantities {
   // Convert from log-odds space to probability space
   vector[J] p;
   p = inv_logit(theta_std*tau);
}










