{% macro variance() %}
{% set query %}
with before_count as
(
SELECT table_name ,
       row_count as before_rowCount
from information_schema.tables
WHERE  table_name IN ('ADDRESS','CUSTOMER','EMPLOYEE')
ORDER  BY row_count desc
),
after_count as
(
SELECT table_name,
       row_count as after_rowCount
 from information_schema.tables
WHERE  table_name IN ('STG_ADDRESS','STG_CUSTOMER','STG_EMPLOYEE')
ORDER  BY row_count desc
),
variance_test as (
select BEFORE_COUNT.table_name,
 BEFORE_COUNT.before_rowCount,
 AFTER_COUNT.after_rowCount,((after_rowcount+100-before_rowcount)/before_rowcount)*100 
 as variance_percent
from BEFORE_COUNT join AFTER_COUNT on CONCAT('STG_',before_count.table_name)=after_count.table_name
)
select * from variance_test where variance_percent>270;
{% endset %}


{% set results = run_query(query) %}
{% if results|length > 0 %}
     {{ exceptions.raise_compiler_error("variance check failed " ~ results|length ) }}
{% else %}
    {{query}}
{% endif %}





{% endmacro %}