![MIKES DATA WORK GIT REPO](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_01.png "Mikes Data Work")        

# If Not Exists Create SQL Triggers For SQL Job Alerts
**Post Date: August 4, 2015**        



## Contents    
- [About Process](##About-Process)  
- [SQL Logic](#SQL-Logic)  
- [Author](#Author)  
- [License](#License)       

## About-Process

<p>Here's some SQL logic that checks for the Trigger [trig_check_for_job_failure]. If it does not exist it will automatically create it. Again; what this trigger does is simply executes the Job: Send SQL JOB Alerts which was created on a former post. All the logic is there to create the Alerts, Trigger, and Job, but… In case you wanted something to check on the trigger first; I've included the logic below. Hope it's helpful.</p>      


## SQL-Logic
```SQL

se msdb;
set nocount on
 
if not exists (select name from msdb..sysobjects where name = 'trig_check_for_job_failure' and type = 'tr') exec dbo.sp_executesql @statement = N'
create trigger [dbo].[trig_check_for_job_failure] on [dbo].[sysjobhistory] after insert
as
begin
set nocount on
declare @is_fail    int
set @is_fail    = (select case when [message] like ''%The step failed%'' then 1 else 0 end from msdb..sysjobhistory where instance_id in (select max(instance_id) from [msdb]..[sysjobhistory])) if @is_fail    = 1
begin
exec msdb.dbo.sp_start_job @job_name = ''SEND SQL JOB ALERTS'' end
end'
```


[![WorksEveryTime](https://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://shitday.de/)

## Author

[![Gist](https://img.shields.io/badge/Gist-MikesDataWork-<COLOR>.svg)](https://gist.github.com/mikesdatawork)
[![Twitter](https://img.shields.io/badge/Twitter-MikesDataWork-<COLOR>.svg)](https://twitter.com/mikesdatawork)
[![Wordpress](https://img.shields.io/badge/Wordpress-MikesDataWork-<COLOR>.svg)](https://mikesdatawork.wordpress.com/)

     
## License
[![LicenseCCSA](https://img.shields.io/badge/License-CreativeCommonsSA-<COLOR>.svg)](https://creativecommons.org/share-your-work/licensing-types-examples/)

![Mikes Data Work](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_02.png "Mikes Data Work")

