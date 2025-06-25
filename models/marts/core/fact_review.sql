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
    select *
    from {{ref('stg_review')}}

),
dates as (
    select *
    from {{ ref('stg_date')}}
)

select
    listing.listing_id,
    host.host_id,
    dates.date_day as review_date_id,

    -- Metrics
     review_rate,
     number_of_review,
     monthly_reviews




from review
left join listing   on review.listing_id = listing.listing_id
left join host      on listing.host_id = host.host_id
left join dates     on review.last_review = dates.date_day