with date_data as (
    select *
    from {{ ref('stg_date')}}

)
select *
from date_data