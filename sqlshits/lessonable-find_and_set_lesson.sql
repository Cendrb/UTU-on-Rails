SELECT DISTINCT ON (timetables.id)
  lessons.*,
  school_days.date
FROM "lessons"
  INNER JOIN "school_days" ON "school_days"."id" = "lessons"."school_day_id"
  INNER JOIN "timetables" ON "timetables"."id" = "school_days"."timetable_id"
  LEFT JOIN group_timetable_bindings ON timetables.id = group_timetable_bindings.timetable_id
  LEFT JOIN sgroups ON sgroups.id = group_timetable_bindings.sgroup_id
WHERE (1 = -1 OR timetables.sclass_id = 1) AND (2 = -1 OR sgroups.id = 2) AND (lessons.subject_id = 1) AND
      (school_days.date >= '2016-02-08')
ORDER BY timetables.id, school_days.date