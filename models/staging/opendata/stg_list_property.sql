with base_src as (
    select 
        id,
        name,
        "room type",
        "Construction year",
        license,
        "availability 365",
        cancellation_policy,
        house_rules,
        instant_bookable,
        "minimum nights",
        price,
        "service fee"
    from {{ ref("base_airbnb_open_data") }}
),
renamed as (
    select 
         id,
        name,
        "room type" as room_type,
        "Construction year" as construction_year,
        license,
        "availability 365" as availability_365,
        cancellation_policy,
        house_rules,
        instant_bookable as is_instant_bookable,
        "minimum nights" as minimum_nights,
        price,
        "service fee" as service_fee
    from base_src
)
select *
from renamed