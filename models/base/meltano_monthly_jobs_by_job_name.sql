{{ config(materialized='table') }}

with meltano_jobs as (
    select * from {{ref('meltano_jobs')}}
),
meltano_monthly_jobs as (
    select
        to_char(started_at, 'YYYY-MM') as month
        , job_id as job_name
        , count(*) as total_jobs
        , date_trunc('second', avg(job_duration)) as average_job_duration
        , sum(job_duration) as total_job_duration
        , sum(case when state = 'SUCCESS' then 1 else 0 end) as total_successful_jobs
        , sum(case when state = 'FAIL' then 1 else 0 end) as total_failed_jobs
    from meltano_jobs
    group by job_name, to_char(started_at, 'YYYY-MM')
    order by month desc
)
select * from meltano_monthly_jobs