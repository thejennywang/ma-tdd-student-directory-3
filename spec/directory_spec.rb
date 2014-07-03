require 'directory'

describe 'Student Directory' do

	let (:student) {{name: "Jenny", cohort: "June"}}
	let (:student2) {{name: "Hannah", cohort: "June"}}

	it 'starts with no students' do
		expect(students).to be_empty
	end	

	context 'has a menu' do
		it 'displays' do
			selection = "1"
			expect(self).to receive(:display_menu)
			expect(self).to receive(:gets).and_return(selection)
			expect(self).to receive(:choose_action).with(selection)
			get_selection 
		end

		context 'processes different procedures for each choice of action' do
			it '1' do
				expect(self).to receive(:input_new_student)
				choose_action("1")
			end

			it '2' do
				expect(self).to receive(:puts).with(display_list)
				choose_action("2")
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
			# expect(csv).to receive(:<<).with(students[1])
			expect(CSV).to receive(:open).with('./students.csv', 'wb').and_yield(csv)

      students_to_csv(students)
		end
	end

	context 'displays studentswith their information' do
		it 'for one student' do
			expect(display_student(student)).to eq "Jenny, June"
		end

		it 'for the list of students' do
			save(student)
			save(student2)
			expect(display_list).to eq "Jenny, June\nHannah, June"
		end
	end
end


