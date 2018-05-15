#standardSQL
select * from(
  select fullVisitorId, hits.eventInfo.eventLabel as el, min(date) as exp_date, max(if(cd.index=2, cd.value, null)) AS sk_customer, max(if(cd.index=3, cd.value, null)) AS country
  from `ga-ios.101025979.ga_sessions_*` as ga, 
  unnest(hits) as hits, unnest(ga.customDimensions) as cd
  WHERE
    _TABLE_SUFFIX BETWEEN '20180319' AND '20180429'
    and hits.eventInfo.eventCategory = 'apptimizeABTest'
    and hits.eventInfo.eventAction = 'Show / Hide Cancellation'
  group by fullVisitorId, el
  having sk_customer is not null and sk_customer not in ('') and country in ('AU')
)
where el in ('original')
-- where el in ('No cancellation')