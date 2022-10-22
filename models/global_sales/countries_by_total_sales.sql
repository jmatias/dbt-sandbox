

select count(country) as count, country, avg(amount) as avg_amount, sum(amount) as total_amount
from {{source('global_sales', 'cities')}}
         left join {{source('global_sales', 'transactions')}} on cities.city_id = transactions.city_id
group by country sort by total_amount desc;