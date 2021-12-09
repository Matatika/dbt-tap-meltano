-- Assert that there are no jobs in the meltano_jobs table with the state 'RUNNING'

select
    *
from {{ ref('meltano_jobs')}}
where state = 'RUNNING'
