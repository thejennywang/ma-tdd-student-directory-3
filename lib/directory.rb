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

def load_students
	CSV.foreach("./students.csv", "r") do |row|
		students << {name: row[0], cohort: row[1]}
	end
end

def load_students_test(filename)
	CSV.foreach('./test.csv', 'r') do |row|
		students << {name: row[0], cohort: row[1]}
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
	input = gets.chomp
	ask_for_student(info) if input.empty?
	return input	
end

def choose_action(selection)	
	case selection
	when "1"
		input_new_student
	when "2"
		puts display_list
	when "3"
		students_to_csv(students)
	when "4"
		load_students
	when "9"
		exit
	end
end

def get_selection
	display_menu
	selection = gets.chomp
	choose_action(selection)
end

def display_menu
    puts "-----------MAIN MENU-----------"
    puts "1. Add students"
    puts "2. Show all the students"
    puts "3. Save students.csv file"
    puts "4. Load students into directory"
    puts "9. Exit"
    puts "-------------------------------"
    print "Please input your selection: "
end
 