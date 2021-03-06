-- Assert that meltano_jobs contains all jobs from stream_meltano_jobs not including jobs with the state 'RUNNING'

select
    count(*)
from {{ ref('meltano_jobs')}}
having count(*) != (select count(*)
                    from {{ source('meltano', 'stream_meltano_jobs') }}
                    where state != 'RUNNING')
