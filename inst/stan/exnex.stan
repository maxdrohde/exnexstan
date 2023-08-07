data {
  int<lower=1> J; // Number of trial strata
  array[J] int n; // Number of subjects per strata
  array[J] int r; // Number of successes per strata
  array[J] real<lower=0, upper=1> p_exch; // Mixture probability of exchangeability for each strata

  // User set parameters for the priors
  real mu_prior_mean;
  real mu_prior_sd;
  real tau_prior_mean;
  real tau_prior_sd;
  real nex_prior_mean; 
  real nex_prior_sd;
}
parameters {
  real mu;               // Mean of hierarchical log-odds distribution 
  real<lower=0> tau;     // SD of hierarchical log-odds distribution
  vector[J] theta;       // Log-odds for each strata
}
model {
  // Priors
  mu ~ normal(mu_prior_mean, mu_prior_sd); 
  tau ~ normal(tau_prior_mean, tau_prior_sd); // Half-normal prior because of the constraint

  for (j in 1:J) {  // Loop over the trial strata
    target += log_mix(p_exch[j],                                            // Strata-specific mixing parameter
                      normal_lpdf(theta[j] | mu, tau),                      // EX
                      normal_lpdf(theta[j] | nex_prior_mean, nex_prior_sd)  // NEX
                      );
      
    r[j] ~ binomial_logit(n[j], theta[j]);                 // Binomial likelihood with built-in expit transform
  }
}
generated quantities {
   // Convert from log-odds space to probability space
   vector[J] p;
   p = inv_logit(theta);

  // Update mixture proportions
  vector<lower=0, upper=1>[J] p_mix;
  for (j in 1:J) {
    real lp1 = bernoulli_lpmf(0 | p_exch[j])
               + normal_lpdf(theta[j] | mu, tau);
    real lp2 = bernoulli_lpmf(1 | p_exch[j])
               + normal_lpdf(theta[j] | nex_prior_mean, nex_prior_sd);
    p_mix[j] = exp(lp1 - log_sum_exp(lp1, lp2));
  }
}










