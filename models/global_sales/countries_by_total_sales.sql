with cities as (select * from {{source('global_sales', 'cities')}}),
     transactions as (select * from {{source('global_sales', 'transactions')}}),

     countries as (select count(country) as count,
                          country,
                          avg(amount)    as avg_amount,
                          sum(amount)    as total_amount,
                          median(amount) as median_amount
                   from cities
                            left join transactions
                                      on cities.city_id = transactions.city_id
                   group by country)


select *
from countries
order by total_amount desc;