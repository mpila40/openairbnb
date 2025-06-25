with src as (
    select *,
        case
            when "neighbourhood group" in ('Manhattan', 'manhatan') then 'Manhattan'
            when "neighbourhood group" in ('Brooklyn', 'brookln') then 'Brooklyn'
            else "neighbourhood group"
        end as neighbourhood_group
    from {{ source('airbnb','airbnb_cleaned') }}
)

select *
from src