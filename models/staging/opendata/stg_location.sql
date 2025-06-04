with base_src as (
    select 
        country,
        lat,
        long,
        neighbourhood,
        "neighbourhood group"
    from {{ ref("base_airbnb_open_data") }}
),
renamed as (
    select 
        country,
        lat as latitud,
        long as longitud,
        neighbourhood,
        "neighbourhood group" as neighbourhood_group
    from base_src
)
select *
from renamed