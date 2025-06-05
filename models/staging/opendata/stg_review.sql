with base_src as (
    select 
        id,
        "last review",
        "number of reviews",
        "review rate number",
        "reviews per month"
    from {{ ref("base_airbnb_open_data") }}
),
renamed_casted as (
    select 
        id as listing_id,
        to_date("last review",'mm/dd/yyyy') as last_review,
        "number of reviews" as number_of_review,
        "review rate number" as review_rate,
        "reviews per month" as monthly_reviews
    from base_src
),

-- assign a default date or -1 value if find null'
handle_null as (
    select
        {{dbt_utils.generate_surrogate_key(['listing_id'])}} as listing_id,
        {{ handle_null("last_review","'2000-01-01'") }} as last_review,
        {{ handle_null("number_of_review","-1") }} as number_of_review,
        {{ handle_null("review_rate","-1") }} as review_rate,
        {{ handle_null("monthly_reviews","-1") }} as monthly_reviews,
    from renamed_casted
)

select *
from handle_null
