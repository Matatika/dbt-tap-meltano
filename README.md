<a href="https://github.com/Matatika/dbt-tap-meltano/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/Matatika/dbt-tap-meltano"></a> ![dbt logo and 
version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=[%3E=1.0.0;%3C2.0.0]&color=orange)


# dbt-tap-meltano
This dbt package contains models for Matatika's [tap-meltano](https://github.com/Matatika/tap-meltano).

The main focus of the package is to transform stream `tap-meltano` data into usable analytics models.

This package along with the [Analyze Bundle](https://github.com/Matatika/analyze-meltano) are designed intended to work together to provide instant insights on the [Matatika Platform](https://www.matatika.com).

| **model**              | **description** |
| ---------------------- | ------------------------------------------------------------- |
| [meltano_jobs](models/base/meltano_jobs.sql) | All Meltano jobs with their duration |
| [meltano_daily_jobs](models/base/meltano_daily_jobs.sql) | Daily stats of meltano jobs |
| [meltano_daily_jobs_by_job_id](models/base/meltano_daily_jobs_by_job_id.sql) | Daily stats of meltano jobs by job Id|
| [meltano_monthly_jobs](models/base/meltano_monthly_jobs.sql) | Monthly stats of meltano jobs |
| [meltano_monthly_jobs_by_job_id](models/base/meltano_monthly_jobs_by_job_id.sql) | Monthly stats of meltano jobs by job Id|


## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`
```yaml
packages:
  - git: https://github.com/Matatika/dbt-tap-meltano.git
```

### One time setup (after creating a python virtual environment)

    ```
    pip install dbt
    dbt deps
    ```

### development

    ```
    dbt test
    ```

## Database Support
This package has been tested on Postgres and Snowflake.

## Cloud hosting and SaaS
Deploy on the Matatika Platform within minutes. [www.matatika.com](https://www.matatika.com)

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Have questions, feedback, or need help? Please email us at support@matatika.com
- Find all of Matatika's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/Matatika/)
- Learn how to orchestrate [dbt transformations with Matatika](https://www.matatika.com/docs/getting-started/)
- Learn more about Matatika [in our docs](https://www.matatika.com/docs/introduction)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)

---

Copyright &copy; 2021 Matatika
