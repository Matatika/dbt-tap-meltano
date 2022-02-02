-- Assert that the total jobs reported in meltano_monthly_jobs equals the count of jobs from meltano_jobs over the last whole month

select
    sum(total_jobs)
from {{ ref('meltano_monthly_jobs')}}
where month = to_char(current_date - interval '1 month', 'YYYY-MM')
having sum(total_jobs) != (select count(*)
                    from {{ ref('meltano_jobs')}}
                    where to_char(started_at, 'YYYY-MM') = to_char(current_date - interval '1 month', 'YYYY-MM'))