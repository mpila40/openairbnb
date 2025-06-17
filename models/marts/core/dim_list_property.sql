with listing_data as (
    select *
    from {{ ref('stg_list_property')}}

)
select *
from listing_data
