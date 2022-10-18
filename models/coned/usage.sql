select cast(start_time as timestamp),
       cast(end_time as timestamp),
       DATE  as `date`,
       USAGE as usage
from {{ source('coned', 'cned_electric_usage') }}