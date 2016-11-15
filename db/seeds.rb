# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sclass = Sclass.create!(name: "septima", default_timetable_id: 1)
class_members = sclass.class_members.create!([{first_name: "Kana", last_name: "Lukas"},
                                    {first_name: "John", last_name: "Cena"},
                                    {first_name: "Walter", last_name: "White"},
                                    {first_name: "Yvonne", last_name: "Uhuh"},
                                    {first_name: "Stuff", last_name: "Unseen"},
                                    {first_name: "Great", last_name: "Nothing"},
                                    {first_name: "Buchen", last_name: "Aš"},
                                    {first_name: "Lord", last_name: "Crystalis"},
                                    {first_name: "Sange", last_name: "Yasha"}])

baka_account = BakaAccount.create!(username: "", password: "", class_member: class_members.first)
timetable = Timetable.create!(name: "the great rozvrh", baka_account: baka_account, sclass: sclass)


group_category = GroupCategory.create!(name: "hlavní")
sgroups = group_category.sgroups.create!([{name: "první", timetable_abbr: "1"},{name: "druhá", timetable_abbr: "2"}])

school_year = SchoolYear.create!(beginning_year: 2016)
school_year.holidays.create!([{name: "Podzimní prázdniny", holiday_beginning: "2016-10-26", holiday_end: "2016-10-27"},
                {name: "Vánoční prázdniny", holiday_beginning: "2016-12-23", holiday_end: "2017-01-02"},
                {name: "Pololetní prázdniny", holiday_beginning: "2017-02-03", holiday_end: "2017-02-03"},
                {name: "Jarní prázdniny", holiday_beginning: "2017-03-13", holiday_end: "2017-03-19"},
                {name: "Velikonoční prázdniny", holiday_beginning: "2017-04-13", holiday_end: "2017-04-14"},
                {name: "Školní výlety", holiday_beginning: "2017-06-21", holiday_end: "2017-06-23"}])

GroupTimetableBinding.create!(timetable: timetable, sgroup: sgroups.last)
GroupBelonging.create!(class_member: class_members.first, sgroup: sgroups.last)
User.create!(class_member: class_members.first, email: "penis@gmail.com", password: "penis", password_confirmation: "penis", access_level: User.al_superuser)