{% macro fetching_count() %}
      select count(*)
        from {{ ref( 'stg_address' ) }}
{% endmacro %}