require 'directory'  # ~> LoadError: cannot load such file -- directory

describe 'Student Directory' do
	xit 'starts with no students' do
		expect(students).to be_empty
	end	

	context 'adds students to the directory' do

		it 'adds a student' do
			student = {name: "Jenny", cohort: "June"}
			save(student)
			expect(students[0][:name]).to eq "Jenny" 
		end

		it 'adds multiple students' do
			student = {name: "Jenny", cohort: "June"}
			student2 = {name: "Hannah", cohort: "June"}
			save(student)
			save(student2)
			expect((students.size)>1).to be true
		end

		it 'save students to a csv (with stubbing)' do 
      # 1. what's the method call
      # 2. what's the argument(s) if any?
      # 3. what's the return if any
      # 4. what's the sequence of methods that needs to be called
			student = {name: "Jenny", cohort: "June"}
			students = [student]
			csv = double
			expect(csv).to receive(:<<).with(students_list(student))
			# expect(csv).to receive(:<<).with(students[1])
			expect(CSV).to receive(:open).with('./students.csv', 'wb').and_yield(csv)

      students_to_csv(students)
		end
	end
end