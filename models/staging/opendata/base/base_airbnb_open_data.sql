with src as (
    select *
    from {{ source('airbnb','file_data') }}
)

select *
from src