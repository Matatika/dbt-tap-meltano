{{ config(materialized='table') }}

with meltano_jobs as (
    select * from {{ref('meltano_jobs')}}
),
meltano_daily_jobs as (
    select
        started_at::date as date
        , job_id as job_name
        , count(*) as total_jobs
        , date_trunc('second', avg(job_duration)) as average_job_duration
        , sum(job_duration) as total_job_duration
        , sum(case when state = 'SUCCESS' then 1 else 0 end) as total_successful_jobs
        , sum(case when state = 'FAIL' then 1 else 0 end) as total_failed_jobs
    from meltano_jobs
    group by job_name, started_at::date
    order by date desc
)
select * from meltano_daily_jobs