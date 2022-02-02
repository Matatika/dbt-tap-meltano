{{ config(materialized='table') }}

with meltano_jobs as (
    select * from {{ref('meltano_jobs')}}
),
meltano_daily_jobs as (
    select
        started_at::date as date
        , job_id as job_id
        , count(*) as total_jobs
        , round(avg(job_duration_seconds)) as average_job_duration_seconds
        , round(sum(job_duration_seconds)) as total_job_duration_seconds
        , round(min(job_duration_seconds)) as min_job_duration_seconds
        , round(max(job_duration_seconds)) as max_job_duration_seconds
        , sum(case when state = 'SUCCESS' then 1 else 0 end) as total_successful_jobs
        , sum(case when state = 'FAIL' then 1 else 0 end) as total_failed_jobs
    from meltano_jobs
    group by job_id, started_at::date
    order by date desc
),
final as (
    select
        *
        , {{ seconds_to_time("average_job_duration_seconds") }} as average_job_duration
        , {{ seconds_to_time("total_job_duration_seconds") }} as total_job_duration
        , {{ seconds_to_time("min_job_duration_seconds") }} as min_job_duration
        , {{ seconds_to_time("max_job_duration_seconds") }} as max_job_duration
    from meltano_daily_jobs
)
select * from final