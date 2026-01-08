
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
