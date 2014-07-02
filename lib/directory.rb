def students
	@students ||= []
end

def add_student(name, cohort)
	students << {name: name, cohort: cohort} 
end