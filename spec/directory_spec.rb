require 'directory'

describe 'Student Directory' do
	
	context 'adds students to the directory' do

		it 'starts with no students' do
			expect(students).to be_empty
		end

		it 'adds a student' do
			expect(add_student("name", "cohort")).to eq students
		end

		it 'adds multiple students' do
			name1 = "Jenny"
			cohort1 = "June"
			name2 = "Hannah"
			cohort2 = "June"
			add_student(name1, cohort1)
			add_student(name2, cohort2)
			expect((students.size)>1).to be true
		end
	end
end