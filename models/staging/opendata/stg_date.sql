-- generating dates using dbt_utils package
with dates_raw as (
 {{ dbt_utils.date_spine(datepart="day",
    start_date="cast('2010-01-01' as date)",
    end_date="dateadd(year, 2, current_date())"
    ) 
    }}
),

-- extracting some date information and renaming some columns
extracting as (
    select 
        date_day
        , extract(dayofweek from date_day) as day_of_week
        , extract(month from date_day) as month
        , extract(quarter from date_day) as trimester
        , extract(dayofyear from date_day) as day_of_year
        , extract(year from date_day) as year
        from dates_raw
)


select *
from extracting
