with base_src as (
    select 
        "host id",
        "host name",
        host_identity_verified,
        "calculated host listings count"
    from {{ ref("base_airbnb_open_data") }}
),
renamed as (
    select 
        "host id" as host_id,
        "host name" as host_name,
        host_identity_verified as identity_verified,
        "calculated host listings count" as number_of_listing
    from base_src
)
select *
from renamed