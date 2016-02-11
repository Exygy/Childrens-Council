# README #

### API Doc ###

| Field     | Format    | Example |
| --------|---------|-------|
| zipcode_ids  | array of zipcode ids   | [int, int, int, ...]    |
| neighborhood_ids | array of neighborhood ids | [int, int, int, ...]   |
| near_address | string, Google Map address | "string"    |
| ages | array of ages in month | [int, int, int, ...]    |
| open_days | array of day object | [{start_time: time, end_time: time schedule_day_id: int}, ...]    |
| schedule_year_ids | array of schedule year ids | [int, int, int, ...]    |
| care_type_ids | array of care type ids | [int, int, int, ...]    |


```
{
  "zipcode_ids": [1,2,3],
  "neighborhood_ids": [1,2,3],
  "near_address": "4053 18th St, San Francisco, CA 94114, USA",
  "ages": [12,13,14,15,16,17,18,19,20,21,22,23,24],
  "open_days": [
    {start_time: '08:00:00', end_time: '17:00:00', schedule_day_id: 1},
    {start_time: '08:00:00', end_time: '17:00:00', schedule_day_id: 2}
  ],
  "schedule_year_ids": [1,2,3],
  "care_type_ids":  [1,2,3]
}
```
