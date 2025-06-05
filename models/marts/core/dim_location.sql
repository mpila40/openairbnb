with location_data as (
    select *
    from {{ ref('stg_location')}}

)
select *
from location_data