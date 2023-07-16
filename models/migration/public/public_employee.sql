with source as (

    select * from {{ source('public', 'employee') }}

),

renamed as (

    select

       "BusinessEntityID" as businessentityid,
       "LoginID" as loginid,
       "JobTitle" as jobtitle,
       "OrganizationLevel" as organizationlevel

    from source

) ,

convert_nulls_to_a_value as (
SELECT businessentityid,loginid,jobtitle, COALESCE(organizationlevel, 0) AS organizationlevel
FROM renamed
)

select * from convert_nulls_to_a_value