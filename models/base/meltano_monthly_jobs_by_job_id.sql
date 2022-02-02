{{ config(materialized='table') }}

with meltano_jobs as (
    select * from {{ref('meltano_jobs')}}
),
meltano_monthly_jobs as (
    select
        to_char(started_at, 'YYYY-MM') as month
        , job_id as job_id
        , count(*) as total_jobs
        , avg(job_duration_seconds) as average_job_duration_seconds
        , sum(job_duration_seconds) as total_job_duration_seconds
        , min(job_duration_seconds) as min_job_duration_seconds
        , max(job_duration_seconds) as max_job_duration_seconds
        , sum(case when state = 'SUCCESS' then 1 else 0 end) as total_successful_jobs
        , sum(case when state = 'FAIL' then 1 else 0 end) as total_failed_jobs
    from meltano_jobs
    group by job_id, to_char(started_at, 'YYYY-MM')
    order by month desc
),
final as (
    select
        *
        , {{ seconds_to_time("average_job_duration_seconds") }} as average_job_duration
        , {{ seconds_to_time("total_job_duration_seconds") }} as total_job_duration
        , {{ seconds_to_time("min_job_duration_seconds") }} as min_job_duration
        , {{ seconds_to_time("max_job_duration_seconds") }} as max_job_duration
    from meltano_monthly_jobs
)
select * from final