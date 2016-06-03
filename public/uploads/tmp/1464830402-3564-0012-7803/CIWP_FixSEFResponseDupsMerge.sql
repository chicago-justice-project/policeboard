With Dups(SefCategoryId, PlanId)
as (
SELECT [SchoolSEFResponse].[sefCategoryId],
		[SchoolSEFResponse].[planId]
FROM [SchoolSEFResponse]
WHERE [SchoolSEFResponse].[evidence] is not null
GROUP BY [SchoolSEFResponse].[sefCategoryId],
		[SchoolSEFResponse].[planId]
HAVING Count(*) > 1
)
,
Dups2(Id, PlanId, sefCategoryId, evidence, [rank], priorityArea)
as(
select distinct SchoolSEFResponse.*
from Dups 
inner join SchoolSEFResponse 
on SchoolSEFResponse.PlanId = Dups.PlanId
)
select row_number() over (partition by planId, sefCategoryId order by planId, sefCategoryId) as Row, * 
into #Source
from Dups2
order by PlanId, sefCategoryId



select * 
from #Source 