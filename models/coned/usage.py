from pyspark.sql.functions import *


def model(dbt, session):
    usage_df: DataFrame = dbt.source("coned", "cned_electric_usage")

    usage_df = (
        usage_df.withColumn("date", to_timestamp(col("DATE"), "MM-dd-yyyy"))
        .withColumn("start", to_timestamp(col("start_time"), "HH:mm"))
        .withColumn("end", to_timestamp(col("end_time"), "HH:mm"))
        .withColumn(
            "start_time",
            ((col("date").cast("long")) + (col("start").cast("long"))).cast("timestamp"),
        )
        .withColumn(
            "end_time", ((col("date").cast("long")) + (col("end").cast("long"))).cast("timestamp")
        )
        .withColumn(
            "end_time", col("end_time") + expr("INTERVAL 1 minute") - expr("INTERVAL 1 second")
        )
        .drop("start", "end", "date", "NOTES", "TYPE")
        .withColumnRenamed("UNITS", "units")
        .withColumnRenamed("USAGE", "usage")
    )

    return usage_df
