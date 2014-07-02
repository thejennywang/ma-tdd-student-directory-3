require 'CSV'

def students
	@students ||= []
end

def student_info(name, cohort)
	student = {name: name, cohort: cohort} 
end

def save(student)
	students << student
end

def students_list(student)
	student.values
end

def students_to_csv(students)
	CSV.open("./students.csv", "wb") do |csv|
		students.each do |student|
      csv << students_list(student)
    end
	end
end
