file = open('lib/seed_data.sql', 'w')

school_setup = <<-sql
INSERT INTO schools (id, name, min_grade, max_grade)
    VALUES (1, 'Phoenix High School', 9, 12);

INSERT INTO schools (id, name, min_grade, max_grade, next_school_id)
    VALUES (2, 'Phoenix Middle School', 6, 8, 1);

INSERT INTO schools (id, name, min_grade, max_grade, next_school_id)
    VALUES (3, 'Phoenix Elementary School', 1, 5, 2);

INSERT INTO schools (id, name, min_grade, max_grade)
    VALUES (4, 'Tempe High School', 9, 12);

INSERT INTO schools (id, name, min_grade, max_grade, next_school_id)
    VALUES (5, 'Tempe Middle School', 6, 8, 4);

INSERT INTO schools (id, name, min_grade, max_grade, next_school_id)
    VALUES (6, 'Tempe Elementary School', 1, 5, 5);

sql

file.write(school_setup)



first_names = File.read('first_names.csv').split("\n").map(&:capitalize)
last_names = File.read('last_names.csv').split("\n").map(&:capitalize)

school_ids = [1,2,3,4,5,6]
subjects = ["English", "History", "Civics", "Algebra", "Spanish",
            "French", "German", "Geometry", "Calculus", "Programming",
            "PE", "Chemistry", "Physics", "Biology"]

teachers_per_school = 10
students_per_school = 200
classes_per_teacher = 3
classes_per_student = 3
tests_per_student_per_class = 2

teacher_data = ""
class_data = ""
student_data = ""
join_data = ""
test_data =""

school_ids.each do |s|
    teachers_per_school.times do |i|
        teacher_id = (s-1)*teachers_per_school+(i+1)
        f = first_names.sample
        l = last_names.sample

        teacher_data += "INSERT INTO teachers (id, first_name, last_name, school_id) VALUES (#{teacher_id}, \"#{f}\", \"#{l}\", #{s});\n"

        classes_per_teacher.times do |j|
            class_id = (teacher_id-1)*classes_per_teacher+(j+1)
            n = subjects.sample
            class_data += "INSERT INTO classes (id, name, teacher_id) VALUES (#{class_id}, \"#{n}\", #{teacher_id});\n"
        end
    end

    students_per_school.times do |i|
        student_id = (s-1)*students_per_school + (i+1)
        f = first_names.sample
        l = last_names.sample

        if s == 1 or s == 4
            g = [9, 10, 11, 12].sample
        elsif s == 2 or s == 5
            g = [6, 7, 8].sample
        else
            g = [1, 2, 3, 4, 5].sample
        end

        student_data += "INSERT INTO students (id, first_name, last_name, school_id, grade_level) VALUES (#{student_id}, \"#{f}\", \"#{l}\", #{s}, #{g});\n"

        class_ids = (((s-1)*teachers_per_school*classes_per_teacher+1)..(s*teachers_per_school*classes_per_teacher)).to_a.sample(classes_per_student)
        class_ids.each do |class_id|
            join_data += "INSERT INTO classes_students (class_id, student_id) VALUES (#{class_id}, #{student_id});\n"
            tests_per_student_per_class.times do |j|
                score = (60..100).to_a.sample
                test_data += "INSERT INTO tests (name, score, class_id, student_id) VALUES (\"Test #{j+1}\", #{score}, #{class_id}, #{student_id});\n"
            end
        end
    end
end

file.write("/* Teacher Data */\n")
file.write(teacher_data)
file.write("/* Class Data */\n")
file.write(class_data)
file.write("/* Student Data */\n")
file.write(student_data)
file.write("/* Class-Student Join Data */\n")
file.write(join_data)
file.write("/* Test Data */\n")
file.write(test_data)


file.close()

