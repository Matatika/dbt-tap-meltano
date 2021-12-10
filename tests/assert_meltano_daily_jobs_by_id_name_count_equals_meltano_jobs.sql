-- Assert that meltano_daily_jobs_by_job_id jobs count equals the total count of jobs from meltano_jobs for the last 30 days.

select
    sum(total_jobs)
from {{ ref('meltano_daily_jobs_by_job_id')}}
where date >= current_date - interval '5' day
having sum(total_jobs) != (select count(*)
                    from {{ ref('meltano_jobs')}}
                    where started_at::date >= current_date - interval '5' day)