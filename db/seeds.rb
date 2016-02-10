# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CareReason.create([
  { name: 'Employment' },
  { name: 'Looking for Work' },
  { name: 'In School/Training' },
  { name: 'Alternative/Back Up Care' },
  { name: 'Child Protective Services/Respite' },
  { name: 'Enrichment/Development' },
  { name: 'Mildly Ill' },
  { name: 'Other Parental Needs' },
])

ScheduleYear.create([
  { name: 'Full Year' },
  { name: 'School Year Only' },
  { name: 'Summer Only' },
  { name: 'Seasonal/Other' },
])

ScheduleWeek.create([
  { name: 'Full Time' },
  { name: 'Part Time' },
  { name: 'Before School' },
  { name: 'After School' },
  { name: 'Drop In' },
  { name: 'Variable/Flexible' },
  { name: 'Days' },
  { name: 'Evening' },
  { name: 'Overnight' },
  { name: 'Other' },
])
