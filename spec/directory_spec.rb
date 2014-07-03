require 'directory'

describe 'Student Directory' do

	let (:student) {{name: "Jenny", cohort: "June"}}
	let (:student2) {{name: "Hannah", cohort: "June"}}

	it 'starts with no students' do
		expect(students).to be_empty
	end	

	context 'menu' do
		it 'displays menu' do
			selection = "1"
			expect(self).to receive(:display_menu)
			expect(self).to receive(:gets).and_return(selection)
			expect(self).to receive(:choose_action).with(selection)
			get_selection 
		end

		context 'processes different of actions' do
			it '1 allows user to input students' do
				expect(self).to receive(:input_new_student)
				choose_action("1")
			end

			it '2 shows the list of students' do
				expect(self).to receive(:puts).with(display_list)
				choose_action("2")
			end

			it '3 saves students to a csv file' do
				expect(self).to receive(:students_to_csv).with(students)
				choose_action("3")
			end

			it '4 loads list of students into the program' do
				expect(self).to receive(:load_students)
				choose_action("4")
			end

			it '9 exits the program' do
				expect(self).to receive(:exit)
				choose_action("9")
			end
		end
	end

	context 'adds new students' do

		it 'adds a student' do
			save(student)
			expect(students[0][:name]).to eq "Jenny" 
		end

		it 'adds multiple students' do
			save(student)
			save(student2)
			expect((students.size)>1).to be true
		end

		it 'prompts for a student name' do
			name = "Jenny"
			expect(self).to receive(:puts).with "Please enter a name"
			expect(self).to receive(:gets).and_return(name)
			expect(ask_for_student("a name")).to eq "Jenny"
		end

		it 'prompts for a student cohort' do
			cohort = "June"
			expect(self).to receive(:puts).with "Please enter cohort"
			expect(self).to receive(:gets).and_return(cohort)
			expect(ask_for_student("cohort")).to eq "June"
		end
	end

	context 'saves student information' do
		it 'saves entered student info' do
			expect(self).to receive(:ask_for_student).with("a name")
			expect(self).to receive(:ask_for_student).with("cohort")
			expect(self).to receive(:save)
			input_new_student
		end

		it 'save students to a csv' do 
      # 1. what's the method call
      # 2. what's the argument(s) if any?
      # 3. what's the return if any
      # 4. what's the sequence of methods that needs to be called
			students = [student]
			csv = double
			expect(csv).to receive(:<<).with(students_list(student))
			expect(CSV).to receive(:open).with('./students.csv', 'wb').and_yield(csv)

      students_to_csv(students)
		end

		it 'loads students from csv to program' do
			row = "Jenny, June"
			expect(students).to receive(:<<).with({name: row[0], cohort: row[1]})
			expect(CSV).to receive(:foreach).with('./students.csv', 'r').and_yield(row)
			load_students
		end

		it 'load from a real file' do
      load_students_test('./test.csv')
      # expect(students).to eq [{},{}]
		end
	end

	context 'displays students with their information' do
		it 'for one student' do
			expect(display_student(student)).to eq "Jenny, June"
		end

		it 'for the list of students' do
			save(student)
			save(student2)
			expect(display_list).to eq "Jenny, June\nHannah, June"
		end
	end
		
	context 'validates information inputted' do
		it 'checks if string is empty' do
			string = ""
		end
	end
end


