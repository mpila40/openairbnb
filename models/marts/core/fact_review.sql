with listing as (
    select *
    from {{ ref('stg_list_property')}}

),


location as (
    select *
    from {{ ref('stg_location')}}
),

host as (
    select *
    from {{ ref('stg_host')}}
),

review as (
    select 
        review.*,
        listing.*
    from  {{ref('stg_review')}} review
    left join listing
    on review.listing_id = listing.id

)

select *
from review