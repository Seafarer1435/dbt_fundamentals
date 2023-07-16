with source as (

    select * from {{ source('public', 'customer') }}

),

renamed as (

    select

       "CustomerID" as customerid,
       "PersonID" as personid,
       "StoreID" as storeid,
       "AccountNumber" as accountnumber

    from source

) ,

convert_nulls_to_a_value as (
SELECT customerid, COALESCE(personid, 0) AS personid,storeid,accountnumber
FROM renamed
)

select * from convert_nulls_to_a_value