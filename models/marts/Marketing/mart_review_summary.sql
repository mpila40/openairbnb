with get_location as (
    select 
        location.neighbourhood_group,
        list.listing_id
    from {{ ref('dim_list_property') }} list
    left join {{ ref('dim_location')}} location
),


get_metrics as (
select
  location.neighbourhood_group as District,
  dates.month as month,
  sum(reviews.number_of_review) total_reviews_monthy
from {{ ref('fact_review') }} reviews
join get_location as location on reviews.listing_id = location.listing_id
join {{ ref('dim_date') }} dates on reviews.review_date_id = dates.date_day
group by 1,2
order by 2 desc
)

select
    *
from get_metrics