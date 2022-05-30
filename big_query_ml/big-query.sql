
-- Step 1: Train our ARIMA time-series model
CREATE OR REPLACE MODEL
  `ecolo-350814.electricty_dataset.usage_forecasting`
options(
  model_type='ARIMA',
  TIME_SERIES_TIMESTAMP_COL="created_datetime",
  TIME_SERIES_DATA_COL='Global_active_power',
  DATA_FREQUENCY="PER_MINUTE"
) as
SELECT
  datetime(date, time) as created_datetime,
  Global_active_power
FROM
  `ecolo-350814.electricty_dataset.electricty`
where date between '2010-01-01' and '2010-11-26'


-- Step 2: Create our new view, using generated data
CREATE OR REPLACE VIEW
  `ecolo-350814.electricty_dataset.output_datastudio` AS (
    select datetime(date, time) as created_datetime, Global_active_power
    from `ecolo-350814.electricty_dataset.electricty`
    where datetime(date, time) > '2010-11-26 17:00:00'
  union all
  SELECT
    EXTRACT(DATE FROM forecast_timestamp) AS created_datetime,
    forecast_value AS Global_active_power
  FROM
    ml.forecast(model `ecolo-350814.electricty_dataset.usage_forecasting`,
      STRUCT( 180 AS horizon,
        0.5 AS confidence_level)
  ) 
  order by created_datetime
)


-- Step 3: Query our view
SELECT * FROM `ecolo-350814.electricty_dataset.output_datastudio` where created_datetime between '2010-11-26 17:00:00' and '2010-11-26 21:02:00'