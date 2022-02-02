{{ config(materialized='table') }}

with stream_meltano_jobs as (
    select * 
    from {{ source('meltano', 'stream_meltano_jobs') }}
    where state != 'RUNNING'
),
meltano_jobs as (
    select
        *
        , {{ date_diff("started_at", "ended_at", 'second') }} as job_duration_seconds
    from stream_meltano_jobs
),
final as (
    select
        *
        , {{ seconds_to_time("job_duration_seconds") }} as job_duration
    from meltano_jobs
)
select * from final