WITH
    timetamp_values AS (SELECT
                            CAST(TO_TIMESTAMP(start_time, 'HH:mm') AS long) AS start_value,
                            CAST(TO_TIMESTAMP(end_time, 'HH:mm') AS long) AS end_value,
                            CAST(TO_TIMESTAMP(DATE, 'M/d/yyyy') AS long) AS date_value,
                            USAGE AS usage,
                            UNITS AS units

                        FROM
                            {{ source('coned', 'cned_electric_usage') }}),

    usage AS (SELECT
                  CAST((start_value + date_value) AS timestamp) +
                  (INTERVAL 1 MINUTE - INTERVAL 1 millisecond) AS start_time,
                  CAST((end_value + date_value) AS timestamp) +
                  (INTERVAL 1 MINUTE - INTERVAL 1 millisecond) AS end_time,
                  usage,
                  units
              FROM
                  timetamp_values)

SELECT *
FROM
    usage;
