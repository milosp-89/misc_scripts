-- nested view and some add transformations

create view some_views as
select
	convert(int, submission_id) as submission_id,
	cast(consent as nchar(10)) as consent,
	iif(form_name = 'NULL', NULL, form_name) as form_name,
	case
		when male_child = 0 and male_adult = 0 and male_old = 0 and female_child = 0 and female_adult = 0 and female_old = 0
		then (female_pregnant + disabled)
		else household_size
	end as household_size,
	iif(crop_cause_loss_harvesting = 'NULL' or crop_cause_loss_harvesting = '', NULL, crop_cause_loss_harvesting) as crop_cause_loss_harvesting
	
from
	(select
		convert(date, full_date, 105) as full_date,
		case
			when crop_land_unit = 'm2' then (iif(crop_land = 0, NULL, crop_land) / 10000)
			when crop_land_unit = 'are' then (iif(crop_land = 0, NULL, crop_land) /100)
			when crop_land_unit = 'hectare' then (iif(crop_land = 0, NULL, crop_land) /1)

		end as crop_land_ha_only,
		cast(replace(replace(crop_postharvest_losses_yn, 'yes', 'Yes'), 'no', 'No') as nchar(10)) as crop_postharvest_losses_yn,
		iif(charindex('Spillage', crop_cause_loss_harvesting)>0 OR charindex('spillage', crop_cause_loss_harvesting)>0, 'Spillage', NULL) as Spillage_loss,
		cast(iif(crop = 'NULL' or crop = '', NULL, crop) as nvarchar(50)) as crop,
		cast(iif(replace(crop_cause_loss_harvesting, '@', ',') = 'NULL', NULL, replace(crop_cause_loss_harvesting, '@', ','))  as nvarchar(500)) as crop_cause_loss_harvesting,
		datepart(year, date) as year_date,
		case
			when right(crop,1) = ',' then (left(crop,len(crop)-1))
			else crop
		end as cropp,
		format(date, 'dd-MM-yyyy') as full_date
	from [dbo].[another_view]) as previous_view;
go
