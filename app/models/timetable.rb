class Timetable < ActiveRecord::Base
  has_many :school_days, -> { order(date: :asc) }, dependent: :destroy
  belongs_to :baka_account
  validates :name, :baka_account, :group, presence: {presence: true, message: 'nesmí být prázdný'}

  def get_timetable
    browser = Mechanize.new

    page = browser.get('http://84.42.144.180/bakaweb/login.aspx')

    page.encoding = 'utf-8'

    form = page.forms.first
    form['ctl00$cphmain$Loginname'] = baka_account.username
    form['ctl00$cphmain$TextBoxHeslo'] = baka_account.password
    form['ctl00$cphmain$ButtonPrihlas'] = 'Přihlásit'
    form['__EVENTTARGET'] = ''
    form['__EVENTARGUMENT'] = ''
    form['ctl00$cphmain$Loginname1'] = ''
    form['ctl00$cphmain$Loginname2'] = ''

    page = form.submit(form.buttons.first)

    page = browser.click(page.link_with(text: /Rozvrh/))

    form = page.forms.first
    form['ctl00$cphmain$radiorozvrh'] = 'rozvrh na příští týden'
    form['__EVENTTARGET'] = 'ctl00$cphmain$radiorozvrh'
    form['__EVENTARGUMENT'] = ''
    form['ctl00$cphmain$Flyrozvrh$checkucitel'] = 'on'
    form['ctl00$cphmain$Flyrozvrh$checkskupina'] = 'on'
    form['ctl00$cphmain$Flyrozvrh$Checkmistnost'] = 'on'

    page = form.submit

    parse_timetable_from_html_and_save_to_db(page.body, self)


    page = browser.get('http://84.42.144.180/bakaweb/login.aspx')

    page = browser.click(page.link_with(text: /Rozvrh/))

    form = page.forms.first
    form['ctl00$cphmain$radiorozvrh'] = 'rozvrh na tento týden'
    form['__EVENTTARGET'] = 'ctl00$cphmain$radiorozvrh'
    form['__EVENTARGUMENT'] = ''
    form['ctl00$cphmain$Flyrozvrh$checkucitel'] = 'on'
    form['ctl00$cphmain$Flyrozvrh$checkskupina'] = 'on'
    form['ctl00$cphmain$Flyrozvrh$Checkmistnost'] = 'on'

    page = form.submit

    parse_timetable_from_html_and_save_to_db(page.body, self)
  end

  def get_current_week_days
    current_date = Date.today
    return self.school_days.where(:date => current_date.beginning_of_week..current_date.end_of_week)
  end

  def get_next_week_days
    next_week_date = Date.today + 1.week
    return self.school_days.where(:date => next_week_date.beginning_of_week..next_week_date.end_of_week)
  end

  def get_next_hour_for(subject, date, counter = 0)
    return Lesson.joins(school_day: :timetable).where('timetables.id = ?', self.id).where('school_days.date >= ?', date).where(subject: subject).order('school_days.date').offset(counter).first
  end

  def self.timetable_for(subject, group)
    if group == 0
      # not group dependent
      if subject.name == 'HuO'
        # use HuO group (first)
        return Timetable.where(group: 1).first
      else
        # use VýO group (second)
        return Timetable.where(group: 2).first
      end
    else
      # group dependent
      return Timetable.where(group: group).first
    end
  end

  private
  # Parses data from a html (source = string) and saves to the given timetable (target = Timetable)
  def parse_timetable_from_html_and_save_to_db(source, target)
    # delete old records
    SchoolDay.where('date < ?', 1.week.ago).destroy_all

    doc = Nokogiri::HTML(source)

    timetable = doc.at_css('div#trozvrh')

    days = timetable.css('tr')

    # remove first element (časy a trvání hodin)
    days.shift

    days.each do |day|
      date = Date.parse(day.at_css('td.r_rozden div.r_bunkaden div.r_datum').content + Time.now.year.to_s)

      duplicates = SchoolDay.where(date: date, timetable: self).destroy_all

      lessons = day.children

      school_day = target.school_days.create(date: date, timetable: target)

      counter = 0
      lessons.each do |lesson|

        if (lesson['class'] != 'r_rozden')
          counter += 1

          if (!lesson.at_css('div.r_bunka_2').nil?)
            # asi přednáška
            first_part = lesson.at_css('div.r_bunka_2').at_css('div.r_bunka_in2')
            subject_string = first_part.at_css('div.r_predm_in2').content
            teacher_string = first_part.at_css('div.r_ucit_in2')['title']
            abbr_string = first_part.at_css('div.r_ucit_in2').content
            room = first_part.at_css('div.r_mist_in2').content

            subject = Subject.find_or_create_by(name: subject_string)

            teacher = Teacher.find_by_name(teacher_string)
            if (!teacher)
              teacher = Teacher.create(name: teacher_string, group: 0, abbr: abbr_string)
            end

            school_day.lessons.create(subject: subject, room: room, teacher: teacher, serial_number: counter)
          else

            if (!lesson.at_css('div.r_denabs').nil?)
              # akce školy
              school_day.lessons.create(subject: nil, room: nil, teacher: nil, serial_number: counter, event_name: lesson.at_css('div.r_denabs').content)
            else
              if (lesson['class'] != 'r_rr')
                rinfo = lesson.at_css('div.rinfo')

                if (!rinfo.nil? && lesson.at_css('div.r_predm').nil?)
                  # removed lesson - add empty
                  school_day.lessons.create(subject: nil, room: nil, teacher: nil, serial_number: counter, not_normal: true, not_normal_comment: rinfo['title'])
                else
                  subject_string = lesson.at_css('div.r_predm').content
                  room = lesson.at_css('div.r_mist').content
                  teacher_string = lesson.at_css('div.r_ucit')['title']
                  abbr_string = lesson.at_css('div.r_ucit').content

                  subject = Subject.find_or_create_by(name: subject_string)

                  teacher = Teacher.find_by_name(teacher_string)
                  if (!teacher)
                    group_string = lesson.at_css('div.r_skup')
                    if (!group_string)
                      group_string = 0
                    else
                      group_string = group_string.content
                    end
                    teacher = Teacher.create(name: teacher_string, group: group_string.to_s.to_i, abbr: abbr_string)
                  end

                  if (!rinfo.nil?)
                    school_day.lessons.create(subject: subject, room: room, teacher: teacher, serial_number: counter, not_normal: true, not_normal_comment: rinfo['title'])
                  else
                    school_day.lessons.create(subject: subject, room: room, teacher: teacher, serial_number: counter)
                  end
                end
              end
            end
          end
        end
      end
      # executed after loading a day
    end

    # executed after loading a timetable
    Exam.in_future.find_each do |exam|
      exam.find_and_set_lesson
      exam.save!
      # puts "\n\n\n\n\n\n#{exam.date} X #{exam.lesson.school_day.date}\n\n\n\n\n\n\n"
    end

    # executed after loading a timetable
    Task.in_future.find_each do |task|
      task.find_and_set_lesson
      task.save!
      # puts "\n\n\n\n\n\n#{task.date} X #{task.lesson.school_day.date}\n\n\n\n\n\n\n"
    end
  end
end