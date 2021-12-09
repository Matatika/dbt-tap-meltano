{{ config(materialized='table') }}

with stream_meltano_jobs as (
    select * 
    from "{{var('schema')}}".stream_meltano_jobs
    where state != 'RUNNING'
),
meltano_jobs as (
    select
        *
        , date_trunc('second', ended_at - started_at) as job_duration
    from stream_meltano_jobs
)
select * from meltano_jobs