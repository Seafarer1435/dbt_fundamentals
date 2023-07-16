with source as (

    select * from {{ source('public', 'address') }}

),

renamed as (

    select

       "AddressID" as addressID,
       "AddressLine1" as addressline1,
       "AddressLine2" as AddressLine2,
       "City" as city

    from source

) ,

convert_nulls_to_a_value as (
SELECT addressID,addressline1, COALESCE(AddressLine2, 'Not Defined') AS AddressLine2,city
FROM renamed
)

select * from convert_nulls_to_a_value