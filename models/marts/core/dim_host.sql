with host_data as (
    select *
    from {{ ref('stg_host')}}
)

select * 
from host_data
