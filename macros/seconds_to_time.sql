
{% macro seconds_to_time(seconds) %}
  {{ return(adapter.dispatch('seconds_to_time')(seconds)) }}
{% endmacro %}


{% macro default__seconds_to_time(seconds) %}

    {{ seconds }} * interval '1 second'

{% endmacro %}


{# postgres should use default #}
{% macro postgres__seconds_to_time(seconds) %}

    {{ return(default__seconds_to_time(seconds)) }}

{% endmacro %}


{% macro snowflake__seconds_to_time(seconds) %}

     time_from_parts(0, 0, {{ seconds }})

{% endmacro %}