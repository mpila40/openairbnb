with base_src as (
    select 
        "last review",
        "number of reviews",
        "review rate number",
        "reviews per month"
    from {{ ref("base_airbnb_open_data") }}
),
renamed as (
    select 
        "last review" as last_review,
        "number of reviews" as number_of_review,
        "review rate number" as review_rate,
        "reviews per month" as monthly_reviews
    from base_src
)
select *
from renamed
