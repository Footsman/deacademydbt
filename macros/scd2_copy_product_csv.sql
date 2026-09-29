{% macro scd2_copy_product_csv(table_nm) %}

delete from {{ var('scd2_db') }}.{{ var('scd2_wrk_schema') }}.{{ table_nm }};

copy into {{ var('scd2_db') }}.{{ var('scd2_wrk_schema') }}.{{ table_nm }}
from (
  select
      $1, $2, $3, $4, $5, $6, $7, $8, $9, $10,
      current_timestamp(), current_timestamp(),
      metadata$filename, metadata$file_row_number
  from @{{ var('scd2_stage') }}
)
file_format = (format_name = '{{ var("scd2_file_format") }}')
purge = {{ var('scd2_purge') }}
force = true;

{% endmacro %}