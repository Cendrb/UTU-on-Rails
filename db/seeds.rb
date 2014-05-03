# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

events = [
  {
    title: "Představení ab Ivona",
     description: "Představení o správné soudružce budovatelce Ivoně. Varování: představení trvá cca 23 hodin => spacáky s sebou", 
     location: "Divadlo Rododendron", 
     event_start: "10.9.2015", 
     event_end: "11.9.2015", 
     pay_date: "1.9.2015", 
     price: 696
     },
     {
    title: "Představení Pyj na scéně",
     description: "Krátké představení. V hlavní roli Penis.", 
     location: "Biograf Modřany", 
     event_start: "10.9.2016", 
     event_end: "11.9.2016", 
     pay_date: "11.9.2016", 
     additional_info_url: "http://lmgtfy.com"
     } 
]

tasks = [
  {
    title: "Zabít Andršovou",
     description: "Co dodat?!", 
     date: "22.2.2222",
     subject: 'NJ',
     group: 2
     },
     {
    title: "Odstřelit pomník IS",
     description: "69 TNT snad bude stačit :)", 
     subject: 'MA',
     date: "23.3.2069",
     group: 0,
     additional_info_url: "http://penis.com"
     } 
]

exams = [
  {
    title: "Rake test",
     description: "O kurwa", 
     date: "11.11.2211",
     subject: 'CH',
     group: 2
     },
     {
    title: "Maturita",
     description: "Hurry up!", 
     subject: 'AJ',
     date: "23.3.2069",
     group: 1,
     additional_info_url: "http://helpforenglish.com"
     },
     {
     title: "Buchbuchhure test",
     description: "69 TNT snad bude stačit :)", 
     subject: 'D',
     date: "23.3.22323",
     group: 0,
     } 
]

services = [
  {
    first_name: "Mária Halbrštátová",
    second_name: "Ivona Součková",
    service_start: "23.2.2069",
    service_end: "30.9.2069"
  },
  {
    first_name: "Irina Kobylková",
    second_name: "Libuše Sakalová",
    service_start: "23.2.2023",
    service_end: "30.9.2023"
  }
]

events.each do |params|
  Event.create(params)
end
tasks.each do |params|
  Task.create(params)
end
exams.each do |params|
  Exam.create(params)
end
services.each do |params|
  Service.create(params)
end
User.create(name: "Halbrštátová", email: "penis@gmail.com", password: "penis", password_confirmation: "penis", admin: true, group: 2)