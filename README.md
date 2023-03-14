# EmployeeAttrition

- Obtain employee data maintained by the HR department of a company. This data was extracted from Kaggle.
- Perform data cleaning, manipulation and pre-processing using Python and SQL.
- Perform univariate, bivariate and multivariate analysis to identify various factors leading to employee attrition. 
- Use Tableau to create interactive visualizations and dashboards to track attrition metrics, and analyze latest trends.
- Suggest employee retention methods by targetting issues that contribute heavily to employee attrition.


## Data Analysis

The process of analysis was broken down into following sections:
- Univariate analysis → To summarize the main characteristics of each attribute and describe its distribution, central tendency, dispersion, and shape. 
- Bivariate analysis → To determine if there is a relationship or association between each independent variable, and the dependent variable ‘turnover’
- Multivariate analysis → To understand the relationships and dependencies among important features and the dependent variable ‘turnover’

### Univariate analysis

- There are 12000 employees in 'XYZ Corp', and 2000 have left the company in the last year (almost 17% attrition rate). The company has 10 departments, with 'sales', 'technical', and 'support' departments comprising 61% of the total employees.
- The average satisfaction level is around 62%, with 58% of the employees highly satisfied, and 12% having low satisfaction. This tells us that people are generally satisfied working in this company, but there is still room for improvement as 42% of the employees feel some level of dissatisfaction. 

<img width="381" alt="image" src="https://user-images.githubusercontent.com/23692906/225117846-5ecead1c-4f0b-4810-ae89-a2f93da464c7.png">

- The average years that people stay in the company is 3.36 years, with the majority of employees spending 2-3 years. However there is a high variation in this value, with minimum value of 2 years and maximum of 10 years.
- The company has high performers, with 53% of the employees getting a high evaluation (> 0.7) last year. The performance average for the company is around 71%. This is an area that needs attention - are high performers leaving the company? Are they satisfied with the company?
- The salary range is highly skewed, with only 8% of the employees falling under the high salary range. This could be due to the fact that generally high compensation is offered to select few positions - the upper management and senior technical managers. However, with 53% of employees receiving very high evaluations, this number seems to be small. Could this be a reason for dissatisfaction among employees? Should the salary offering of the company be revised to offer better compensation to high performers.
<img width="324" alt="image" src="https://user-images.githubusercontent.com/23692906/225118154-e3bfb786-7f99-47e2-9526-e9789e3fbc70.png">

- 'Average monthly hours' for this company is quite high, where 71% of the employees work for more than the standard working hours (160 hours monthly). It follows a bi-modal distribution, peaking at around 160 hours and 260 hours.
<img width="374" alt="image" src="https://user-images.githubusercontent.com/23692906/225118348-304cb83f-2e3a-497b-b04d-d07749eff38d.png">

- Promotion is another factor that seems worrying as less than 3% of the employees received promotion in the last 5 years. The promotion policy demands a revision.

### Bivariate analysis

- As expected, there is a greater turnover percentage among employees with lesser satisfaction (less than 0.5). 
<img width="420" alt="image" src="https://user-images.githubusercontent.com/23692906/225118411-004042f3-a52a-4bbe-95d9-7bcb481ba0ca.png">

- However, we do have 550 employees who were highly satisfied (more than 0.7) who left the company. This is alarming. Of all the employees who left, more than 25% were highly satisfied. These employees' exit interview feedback should be observed closely to know the reason behind their attrition.
<img width="443" alt="image" src="https://user-images.githubusercontent.com/23692906/225118483-851ebdbb-d492-45e8-b19a-b916970a32cd.png">

- Maximum attrition is seen among people who have been in the company for 3-5 years. This could be due to factors like:
    - Low salary growth
    - Not finding the job challenging

<img width="452" alt="image" src="https://user-images.githubusercontent.com/23692906/225118680-cdfc6749-41c0-43c1-8d7c-4d7dd821725a.png">

- The mean evaluation of turnover employees is higher than that of current employees. This means that employees who left were on average better performers than those who stayed.
<img width="418" alt="image" src="https://user-images.githubusercontent.com/23692906/225118786-1e6e0718-bbcb-43a6-97f2-fcf84e7e2064.png">


- Barring just 1 employee, every other employee who left did not receive promotion in the last 5 years. This is compelling evidence that lack of promotion, among other factors, is a big reason that employees leave.
<img width="409" alt="image" src="https://user-images.githubusercontent.com/23692906/225118945-2f9fd678-14d9-49ff-9fe6-c302ef999bca.png">


### Multivariate Analysis

From the above analysis, there are two important issues that stand out and need further analysis:

  #### 1. The mean evaluation rating of turnover employees is higher than that of retained employees. Why did good performers leave?
  #### 2. 25% of the turnover employees were highly satisfied. Why did they leave?

#### Performance wise turnover

The performance wise turnover paints an interesting picture. Only those employees left the company who received a ‘Meets Expectation’ or a ‘Exceeds Expectation’ rating in the last evaluation. 

Also, among employees who received a very high rating (Exceeds Expectation), the majority of them were working for long hours. 

<img width="401" alt="image" src="https://user-images.githubusercontent.com/23692906/225119517-567c0937-78de-492a-baa6-52f12b533031.png">




This is a serious issue that needs immediate redressal. <b> Good performers are leaving the company due to overwork, whereas low performers continue to work in the company. </b>  In fact, out of 2000 turnovers, 1042 were top performers, and overworked:

<img width="265" alt="image" src="https://user-images.githubusercontent.com/23692906/225120207-d79aa6ce-8296-468e-a7f1-3676f0073571.png">


#### Satisfaction wise turnover

To understand why highly satisfied people leave the company, it was important to identify the top factors affecting attrition. Following methods were used to achieve this:

- Visual plots
- ANOVA test: To identify important ‘numerical’ attributes affecting attrition

<img width="469" alt="image" src="https://user-images.githubusercontent.com/23692906/225120298-e1473925-3f9f-4655-99e4-49c127f00dd3.png">


Since ANOVA is used for selecting NUMERICAL features, we'll ignore the CATEGORICAL features from the above list. Following NUMERICAL features have highest correlations with the dependent variable 'turnover'.
    1. satisfaction_level
    2. time_spend_company
    3. average_montly_hours

- Chi-square test: To identify important ‘categorical’ attributes affecting attrition

<img width="477" alt="image" src="https://user-images.githubusercontent.com/23692906/225120573-30880547-e4c8-4e04-aba0-f967233a57e6.png">


Since Chi-square is used for selecting CATEGORICAL features, we'll ignore the NUMERICAL features from the above list. Following CATEGORICAL features have good correlation with the dependent variable 'turnover'.
    1. Work_accident
    2. Salary

- features_importances_ : This method gives weighted importance of all the features that the Machine Learning model used to make predictions for the given dataset.

<img width="474" alt="image" src="https://user-images.githubusercontent.com/23692906/225120729-bf5cb949-19a0-48c3-b6e6-201be3a5643b.png">

Using the features_importances_ report of the Random Forest model, among all the factors, satisfaction_level’, ‘time_spend_company’ and ‘average_monthly_hours’ were identified to be the biggest factors leading to employee turnover. 




Analyzing these 3 factors together: 

<img width="477" alt="image" src="https://user-images.githubusercontent.com/23692906/225120786-86f41467-e640-4c01-8691-1176ca330c9a.png">


<b> The above plot clearly shows that highly satisfied employees who left were working long hours, and had been in the company for 5-6 years.

Also, there seems to be a level of dissatisfaction among employees who were in the company for 3 to 4 years.</b>

Analyzing salary range for this group:

<img width="442" alt="image" src="https://user-images.githubusercontent.com/23692906/225120879-59704620-acf7-40d9-8200-42d8b13ac8c7.png">


<b> Employees who were in the company for 3-4 years had a low-medium salary range.</b>
	

## Key takeaways and Potential solutions:

- Looking at the data, following are the key points: 
- It seems that many people are leaving because of low levels of satisfaction, not getting promoted and over-work. 
- Insufficient compensation is a big reason for dissatisfaction among employees. 
- A common factor among most turnover employees is lack of promotion, due to which employees do not find their jobs rewarding, leading to their attrition.
- Highest attrition is in the HR department, followed by Accounting and Technical teams. 


Based on the above identified factors, following solutions should be put in place:

- <b>Restrict work hours</b> → The HR policy needs a change to implement stricter working hours, not exceeding the expected average of 160 hours per month.
- <b>Better compensation</b> → A common factor among dissatisfied employees was low to medium salary ranges. The company can follow industry standards as criteria to drive its cost to company and salary guidelines.
- <b>Promotion policy review</b> → With more than 99% of turnover employees not getting promoted in 5 years, the promotion policy needs an immediate review to address the extremely low rate of promotion in the company.
Department oriented → Efforts should be more focussed on departments seeing higher attrition rates -  HR, Accounting and Technical.
