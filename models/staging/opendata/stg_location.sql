with base_src as (
    select 
        id,
        country,
        "country code",
        lat,
        long,
        neighbourhood,
        "neighbourhood group"
    from {{ ref("base_airbnb_open_data") }}
),
renamed_casted as (
    select 
        id as listing_id,
        country::varchar(50) as country,
        "country code"::varchar(50) as country_code,
        lat as latitud,
        long as longitud,
        neighbourhood::varchar(250) as neighbourhood,
        "neighbourhood group"::varchar(250) as neighbourhood_group
    from base_src
),

-- assign a 'Unknown or 0 value if find null',
handle_null as (
    select
        {{dbt_utils.generate_surrogate_key(['listing_id'])}} as listing_id,
        country,
        country_code,
        -- in that case we cannot put that as a 0 cause even that represent a coordinates so i put the default city latitud(new york)
        {{ handle_null("latitud","40.7128") }} as latitud, 
        {{ handle_null("longitud","-74.0060") }} as longitud,
        {{ handle_null("neighbourhood","'Unknown'") }} as neighbourhood,
        {{ handle_null("neighbourhood_group","'Unknown'") }} as neighbourhood_group
    from renamed_casted
)

select *
from handle_null