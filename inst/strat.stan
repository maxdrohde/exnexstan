data {
  int<lower=1> J;   // Number of trial strata
  array[J] int n;   // Number of subjects per strata
  array[J] int r;   // Number of successes per strata
}
parameters {
  vector[J] theta;  // Log-odds of response for each strata
}
model {
  for (j in 1:J) {                          // Loop over the trial strata
    theta[j] ~ normal(-1.734, 2.801);       // Prior on log-odds of response (same for each strata) 
    r[j] ~ binomial_logit(n[j], theta[j]);  // Binomial likelihood with built-in expit transform
  } 
}
generated quantities {
   // Convert from log-odds space to probability space
   vector[J] p;
   p = inv_logit(theta);
}










