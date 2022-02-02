
{% macro date_diff(first_date, second_date, date_part) %}
  {{ return(adapter.dispatch('date_diff')(first_date, second_date, date_part)) }}
{% endmacro %}


{% macro default__date_diff(first_date, second_date, date_part) %}

    extract('epoch' from date_trunc('{{ date_part }}', {{ second_date }} - {{ first_date }}))::int

{% endmacro %}


{# postgres should use default #}
{% macro postgres__date_diff(first_date, second_date, date_part) %}

    {{ return(default__date_diff(first_date, second_date, date_part)) }}

{% endmacro %}



{% macro snowflake__date_diff(first_date, second_date, date_part) %}

    timestampdiff('{{ date_part }}', {{ first_date }}, {{ second_date }})

{% endmacro %}