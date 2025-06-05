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
renamed_casted as (
    select 
         id,
        name::varchar(50) as name,
        "room type"::varchar(500) as room_type,
        "Construction year" as construction_year,
        license::varchar(50) as license,
        "availability 365" as availability_365,
        cancellation_policy,
       -- house_rules::varchar(700000) as house_rules,
        instant_bookable as is_instant_bookable,
        "minimum nights" as minimum_nights,
        replace(replace(price,'$',''),',','')::decimal(10,3) as price,
        replace(replace("service fee",'$',''),',','')::decimal(10,3) as service_fee
    from base_src
),

-- assign a 'Unknown or 0 value if find null',
handle_null_and_surrogate_key as (
    select
        {{dbt_utils.generate_surrogate_key(['id'])}} as id, -- use a surrogate key for host,
        {{ handle_null("name","'Unknown'") }} as name, 
        room_type,
        {{ handle_null("construction_year","0") }} as construction_year, 
        {{ handle_null("license","'Unknown'") }} as license, 
        {{ handle_null("availability_365","0") }} as availability_365, 
        {{ handle_null("cancellation_policy","'Unknown'") }} as cancellation_policy,  
        {{ handle_null("is_instant_bookable","'Unknown'") }} as is_instant_bookable, 
        {{ handle_null("minimum_nights","0") }} as minimum_nights, 
        {{ handle_null("price","0") }} as price, 
        {{ handle_null("service_fee","0") }} as service_fee
    from renamed_casted

)
select *
from handle_null_and_surrogate_key