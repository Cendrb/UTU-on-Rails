class Timetable < ActiveRecord::Base
  has_many :school_days,  -> { order(date: :asc) }, dependent: :destroy
  belongs_to :baka_account
  validates :name, :baka_account, presence: {presence: true, message: "nesmí být prázdný"}
  
  def get_timetable
    browser = Mechanize.new
    
    page = browser.get('http://84.42.144.180/bakaweb/login.aspx')
    
    page.encoding = 'utf-8'
    
    form = page.forms.first
    form["ctl00$cphmain$Loginname"] = baka_account.username
    form["ctl00$cphmain$TextBoxHeslo"] = baka_account.password
    form["ctl00$cphmain$ButtonPrihlas"] = "Přihlásit"
    form["__EVENTTARGET"] = ""
    form["__EVENTARGUMENT"] = ""
    form["ctl00$cphmain$Loginname1"] = ""
    form["ctl00$cphmain$Loginname2"] = ""
    
    page = form.submit(form.buttons.first)
    
    page = browser.click(page.link_with(text: /Rozvrh/))
    
    form = page.forms.first
    form["ctl00$cphmain$radiorozvrh"] = "rozvrh na příští týden"
    form["__EVENTTARGET"] = "ctl00$cphmain$radiorozvrh"
    form["__EVENTARGUMENT"] = ""
    form["ctl00$cphmain$Flyrozvrh$checkucitel"] = "on"
    form["ctl00$cphmain$Flyrozvrh$checkskupina"] = "on"
    form["ctl00$cphmain$Flyrozvrh$Checkmistnost"] = "on"
    
    page = form.submit
    
    parse_timetable_from_html_and_save_to_db(page.body, self)
    
    
    page = browser.get('http://84.42.144.180/bakaweb/login.aspx')
    
    page = browser.click(page.link_with(text: /Rozvrh/))
    
    form = page.forms.first
    form["ctl00$cphmain$radiorozvrh"] = "rozvrh na tento týden"
    form["__EVENTTARGET"] = "ctl00$cphmain$radiorozvrh"
    form["__EVENTARGUMENT"] = ""
    form["ctl00$cphmain$Flyrozvrh$checkucitel"] = "on"
    form["ctl00$cphmain$Flyrozvrh$checkskupina"] = "on"
    form["ctl00$cphmain$Flyrozvrh$Checkmistnost"] = "on"
    
    page = form.submit
    
    parse_timetable_from_html_and_save_to_db(page.body, self)
  end
  
  private
    # Parses data from a html (source = string) and saves to the given timetable (target = Timetable)
  def parse_timetable_from_html_and_save_to_db(source, target)
    doc = Nokogiri::HTML(source)
    
    timetable = doc.at_css("div#trozvrh")
    
    days = timetable.css("tr")
    
    # remove first element (časy a trvání hodin)
    days.shift
    
    days.each do |day|
      #day_title = day.at_css("td.r_rozden div.r_bunkaden div.r_den").content
      date = Date.parse(day.at_css("td.r_rozden div.r_bunkaden div.r_datum").content + Time.now.year.to_s)
      
      duplicates = SchoolDay.where(date: date)
      duplicates.each do |duplicate|
        duplicate.destroy
      end

      #lessons = day.css("td.r_rrw div.r_bunka, td.r_rrzm div.r_bunkazm")
      lessons = day.children

      school_day = target.school_days.create(weekday: days.index(day), date: date, timetable: target)
      
      counter = 0
      
      lessons.each do |lesson|
        puts lesson
        
        if(lesson["class"] != "r_rozden")
          counter += 1
          if(!lesson.at_css("div.r_denabs").nil?)
            # akce školy
            school_day.lessons.create(subject: nil, room: nil, teacher: nil, serial_number: counter, event_name: lesson.at_css("div.r_denabs").content)
          else
            if(lesson["class"] != "r_rr")
              rinfo = lesson.at_css("div.rinfo")
              
              if(!rinfo.nil? && lesson.at_css("div.r_predm").nil?)
                # removed lesson - add empty
                school_day.lessons.create(subject: nil, room: nil, teacher: nil, serial_number: counter, not_normal: true, not_normal_comment: rinfo["title"])
              else  
                subject_string = lesson.at_css("div.r_predm").content
                room = lesson.at_css("div.r_mist").content
                teacher_string = lesson.at_css("div.r_ucit")["title"]
                abbr_string = lesson.at_css("div.r_ucit").content
                puts subject_string
                
                subject = Subject.find_by_name(subject_string)
                if(!subject)
                  subject = Subject.create(name: subject_string)
                end
                
                teacher = Teacher.find_by_name(teacher_string)
                if(!teacher)
                  group_string = lesson.at_css("div.r_skup")
                  if(!group_string)
                    group_string = 0
                  else
                    group_string = group_string.content
                  end
                  teacher = Teacher.create(name: teacher_string, group: group_string.to_s.to_i, abbr: abbr_string)
                end
                
                if(!rinfo.nil?)
                  school_day.lessons.create(subject: subject, room: room, teacher: teacher, serial_number: counter, not_normal: true, not_normal_comment: rinfo["title"])
                else
                  school_day.lessons.create(subject: subject, room: room, teacher: teacher, serial_number: counter)
              end
            end
            end
          end
        end
      end
    end
  end
end
