# Outline for bias

##### introduction

I recently was asked to create a predictive model for financial loans. The data I was given for training consisted of about 100,000 U.K. loan applications. The data included whether each loan was either approved or denied and, if approved, whether or not it was repaid. The grading for the predictive model I was tasked to build was simply +1 if the model said give a loan and it was repaid, -1 if the model said give a loan and it wasn't repaid, and 0 if the modeled said do not give a loan.

Reading this problem statement made me realize two things. First, the people asking me to do this problem had no clear understanding of what is possible to learn from this data. As stated, the problem is impossible because in the model grading, there is no recognition of a fourth possible outcome: the model predicts a loan should be given and the outcome of the loan is unknown. This occurs when in the training data the bank did not give a loan. Handling this problem is an incredibly complex problem and key to building any prediction on loans.

Second, the selection bias, which is the source of the immediate difficulty, is extreme in this data: the only people for whom loan repayment information is known, are those who received loans. The likelihood of repayment for people who did not receive loans is completely absent.

Selection bias is a known issue in data science, but the depth of which is not fully appreciated. As is the case this particular problem, there is no simple solution to handle the bias. The selection bias makes this data set far from a value-neutral source from which we can learning. To blindly run analysis on this data risks would infect any unwanted bias in the initial data thereby perpetuating any discrimination in financial loans.  

### Selection bias

Selection bias occurs whenever the data are not representative of the true underlying distribution. Cicero writes about the atheist Diagoras. A friend tries to convince him of the existence of the gods by pointing to the paintings of men saved from storms on the sea through prayer. Diagoras responds "there are nowhere any pictures of those who have been shipwrecked and drowned at sea." If you want to create a sample of all people who pray, but only include those who commission paintings of themselves surviving storm, the selection bias precludes anyone who drowned.

Once you start looking for selection bias, it is easy to spot. Right now in the U.S. we are inundated with political polls in the run-up to the presidential election. These polls try to be representative of U.S. voters, but struggle with selection bias. Pollsters put in a lot of effort to minimize this and are open about their methodology.[^Rasmussen]

This is, by the way, a huge part of the value added by fiverthirtyeight.com and the Upshot at the New York Times. They model how the selection bias in different polls is likely correlated. For example, the selection bias in polls in Ohio are likely to be strongly correlated to the selection bias in Michigan, but less correlated in North Carolina because of the different demographics. So if Donald Trump outperforms the polls and wins in Ohio, he is more likely to also outperform in Michigan than in North Carolina.[^fivethirtyeight]

Data from applications, whether for jobs, colleges, or loans, almost always have a huge selection bias. In all applications, it is always much easier to obtain data from the people that were accepted. A university that wants to assess their undergraduate admissions could run a test to see how well their selection process correlates with graduation rate or GPA of the admitted students. But the same university could never run a test to see how well a student whom they rejected would have performed. The same core problem exists in financial data.

 The only way a university could fully assess their admissions would be to randomly admit some students for whom the admission process says reject. This is

##### observation bias definition

##### Examples
college applications
job applications
all applications
-- huge cost to explore

#### Back to the financial data

For loan modeling, for each loan, we have as input data $x$, which can include information like current salary, savings account balance, loan purpose and other financial information. But it can also include demographic information like age, gender, and ethnicity as well geographical information like zip code.

The ultimate goal of loan modeling is to predict the probability that a loan would be repaid given $x$.

$$ P(LoanRepaid | x) $$

The challenge is that what we actually have in the data is the probability that a loan was granted by the bank from which we are learning: $P(LoanGranted | x)$. And if the loan was given, the probability that it was repaid _given a loan was granted_ $P(LoanRepaid | LoanGranted, x)$. The additional conditional statement makes a huge difference and presents quite a challenge.

A naive approach is to approximate $ P(LoanRepaid | x)$ as $P(LoanRepaid | LoanGranted, x)$. Concretely, this is done by throwing out training cases in which the loan was not given and learning to classify loans as either repaid or not repaid. This has the nice feature of avoiding the pesky NAs that appear whenever the loan was denied. But has the bad feature of being terrible wrong.

A classifier built on this is worthless as it learns on data that is not representative of the distribution of new loan applications. For example, a binary feature `is_employed` of a loan applicant should be useful in determining if a loan would be repaid. However, when following the naive approach, `is_employed` has almost no predictive power for the simple reason that damn near every loan was given to someone employed. In other words, `is_employed` is very predictive of if a loan is given. But not useful for predicting if a loan is repaid because we have nearly no data on an unemployed applicant receiving a loan.

A different approach would be to directly model $P(LoanRepaid | LoanGranted, x)$ and $P(LoanGranted | x)$. This means building two separate models. The first model is exactly the same as the naive model above. The second model is trained to predict whether or not the bank from whom the training data came would issue a loan. The decision to grant a loan would occur only if there is a high probability that the loan was granted by the bank _and_ a high probability that a loan would be repaid given it was granted.

probability math P(loan repaid | loan given, x) = P(loan repaid | x) * p(loan given | x) != P(loan repaid | x)

##### learning options
lean P(loan given | x) and P(loan repaid| loan given, x) and approximate P(loan repaid | x) as P(loan repaid | lg, x) P(lg | x)

##### Problems
Learning from data. The history of that data infects current interpretation. Loan decisions (racist) from the 60's infects decisions in the 70s, which then infects the 80s, etc.

##### Where does this exist?
Situations in which the number of accepted are limited (hiring, college apps) but also loans in situations in which capital is limited, not customers.

political

[^Rasmussen] [Rasumssen Methodology](http://www.rasmussenreports.com/public_content/about_us/methodology)

 [^Scientific American] [Scientific American Blog](https://blogs.scientificamerican.com/guest-blog/where-are-the-real-errors-in-political-polls/)

 [^fivethirtyeight] [fivethirtyeight](http://fivethirtyeight.com/features/election-update-north-carolina-is-becoming-a-backstop-for-clinton/)
