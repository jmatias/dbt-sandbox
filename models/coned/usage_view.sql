with timetamp_values as (select cast(to_timestamp(start_time, 'HH:mm') as long) as start_value,
                                cast(to_timestamp(end_time, 'HH:mm') as long)   as end_value,
                                cast(to_timestamp(DATE, 'MM-dd-yyyy') as long)  as date_value,
                                USAGE                                           as usage,
                                UNITS                                           as units

                         from {{ source('coned', 'cned_electric_usage') }}),

    usage as (select cast((start_value + date_value) as timestamp) + (interval 1 minute - interval 1 second) as start_time,
                     cast((end_value + date_value) as timestamp) + (interval 1 minute - interval 1 second)   as end_time,
                     usage,
                     units
              from timetamp_values)

select * from usage;

