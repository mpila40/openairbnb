select
  l.neighbourhood_group as city,
  count(*) AS total_reviews,
  max(fr.monthly_reviews) AS max_monthly_reviews

from {{ ref('fact_review') }} fr
join {{ ref('dim_list_property') }} listing
  on fr.listing_id = listing.listing_id
join {{ ref('dim_location')}} l
on listing.listing_id = l.listing_id
group by
  city
