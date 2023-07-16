with source as (

    select * from {{ source('public', 'address') }}

),

renamed as (

    select

       "AddressID" as addressID,
       "AddressLine1" as addressline1,
       "City" as city

    from source

) select * from renamed;