with base_src as (
    select 
        "host id",
        "host name",
        id,
        host_identity_verified,
        "calculated host listings count"
    from {{ ref("base_airbnb_open_data") }}
),
renamed_casted as (
    select 
        "host id" as host_id,
        "host name"::varchar(50) as host_name,
        id as listing_id,
        host_identity_verified::varchar(50) as identity_verified,
        "calculated host listings count" as number_of_listing
    from base_src
),

handle_null_and_surrogate_key as (
    select 
        {{dbt_utils.generate_surrogate_key(['host_id'])}} as host_id, -- use a surrogate key for host
        {{ handle_null("host_name","'Unknown'") }} as host_name, -- assign a 'Unknown value if find null',
        {{dbt_utils.generate_surrogate_key(['listing_id'])}} as listing_id, -- use a surrogate key for host's listing id
        {{ handle_null("identity_verified","'Unknown'") }} as identity_verified, -- assign a 'Unknown value if find null'
        {{ handle_null("number_of_listing","0") }} as number_of_listing, -- assign a 0 value if find null'
    from renamed_casted

)

select *
from handle_null_and_surrogate_key