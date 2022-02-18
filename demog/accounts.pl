select count(creationDate), datepart( YY, creationDate ) AS day,
         datepart( mm, creationDate ) AS month,
         datepart( dd, creationDate ) AS year
from userAccounts
group by  datepart( YY, creationDate ),
          datepart( mm, creationDate ),
          datepart( dd, creationDate )

select count(Ecom_billto_stateprov ),Ecom_billto_stateprov
from creditCards
where Ecom_billto_countrycode = 'US'
group by Ecom_billto_stateprov
order by count(Ecom_billto_stateprov ) desc

select count(Ecom_billto_stateprov ),Ecom_billto_stateprov
from echecks
where Ecom_billto_countrycode = 'US'
group by Ecom_billto_stateprov
order by count(Ecom_billto_stateprov ) desc

select count(Ecom_billto_countrycode ),Ecom_billto_countrycode
from creditCards
group by Ecom_billto_countrycode
order by count(Ecom_billto_countrycode ) desc

select count(Ecom_billto_countrycode ),Ecom_billto_countrycode
from echecks
group by Ecom_billto_countrycode
order by count(Ecom_billto_countrycode ) desc
