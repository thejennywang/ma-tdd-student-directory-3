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

def display_student(student)
	"#{student[:name]}, #{student[:cohort]}"
end

def display_list
	students.map do |student| 
		display_student(student)
	end.join("\n")
end

def input_new_student
	name = ask_for_student("a name")
	cohort = ask_for_student("cohort")
	student = {name: name, cohort: cohort}
	save(student)
end

def ask_for_student(info)
	puts "Please enter #{info}"
	gets.chomp
end

def choose_action(selection)	
	case selection
	when "1"
		input_new_student
	when "2"
		puts display_list
	end
end

def get_selection
	display_menu
	selection = gets.chomp
	choose_action(selection)
end

def display_menu
    puts "--------MAIN MENU---------"
    puts "1. Add students"
    puts "2. Show all the students"
    puts "9. EXIT the awesome program"
    puts "Please input your selection"
end