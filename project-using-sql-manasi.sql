use bank_loan;
select * from finance_1;
select * from finance_2;

# Total Loan Amount
Select sum(loan_amnt) total_loan_amount from finance_1;

# Total loan issued
Select distinct count(member_id) as number_of_loan_issued
from finance_1;

# Cumulative interest rate
Select avg(int_rate) as cumulative_interest_rate
from finance_1;

# Average funded amount
Select avg(funded_amnt) as average_funded_amount
from finance_1;

# KPI 1 Year wise loan amount Stats
select year(issue_d) as issue_years, sum(loan_amnt) as total_amount
from finance_1 
group by issue_years
order by total_amount desc;

select year(issue_d), sum(loan_amnt) from finance_1 
group by year(issue_d)
order by year(issue_d);


#KPI 2 Grade and sub grade wise revol_bal
Select f1.grade, f1.sub_grade, sum(f2.revol_bal) as revolving_bal
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
group by f1.grade, f1.sub_grade;

#KPI 3 Total Payment for Verified Status Vs Total Payment for Non Verified Status
select f1.verification_status, round(sum(f2.total_pymnt),2) as total_payment
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
group by f1.verification_status;



##KPI 4 State wise and month wise loan status
select addr_State, last_Credit_pull_D, loan_Status 
from finance_1 inner join finance_2 on
(finance_1.id = finance_2.id)
group by addr_State, last_Credit_pull_D, loan_status
order by loan_status; 

/* Top 5 States */ 
select addr_state as state_name, count(*) as customer_count
from finance_1
group by addr_state
order by customer_count desc
limit 5;

#### KPI 5 Home ownership Vs last payment date stats
select home_ownership, last_pymnt_d from 
finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by home_ownership, last_pymnt_d
order by home_ownership, last_pymnt_d;

select home_ownership, count(last_pymnt_d) from 
finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by home_ownership;


select 
concat('$',format(round(sum(last_pymnt_amnt)/100000,2),2),'million') as total_payment,
home_ownership, last_pymnt_d from 
finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by home_ownership, last_pymnt_d
order by  last_pymnt_d desc, home_ownership desc;



# KPI 4 State wise and month wise loan status
select addr_state, loan_status, count(loan_status)
from finance_1
group by addr_state, loan_status;

select monthname(f2.last_pymnt_d) pay_month, count(f1.loan_status) as loan_status
from finance_1 as f1 join finance_2 as f2
on f1.id = f2.id
group by pay_month;



# KPI 5 Home ownership Vs last payment date stats
select year(f2.last_pymnt_d) payment_year, monthname(f2.last_pymnt_d) payment_month, f1.home_ownership, count(f1.home_ownership) home_ownership
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
group by year(f2.last_pymnt_d), monthname(f2.last_pymnt_d), f1.home_ownership
order by payment_year;



select year(f2.last_pymnt_d) payment_year, f1.home_ownership, count(f1.home_ownership) home_ownership
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
group by year(f2.last_pymnt_d), f1.home_ownership
order by payment_year;

select year(f2.last_pymnt_d) payment_year, monthname(f2.last_pymnt_d) payment_month, f1.home_ownership, count(f1.home_ownership) home_ownership
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
group by year(f2.last_pymnt_d), monthname(f2.last_pymnt_d), f1.home_ownership
order by payment_year;

/* Yearly Interest Received */

select year(last_pymnt_d) as received_year, cast(sum(total_rec_int) as decimal (10,2)) as interest_received
from finance_2
group by received_year
order by received_year;

/* Term Wise Popularity */
select term, sum(loan_amnt) total_amount from finance_1
group by term;

