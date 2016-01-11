class WrittenExam < Exam
  validates :date, presence: {presence: true, message: "nesmí být prázdný"}
end
