require 'sqlite3'

def get_column_names(table_name)
    result = @db.execute2("SELECT * FROM #{table_name};")
    return result.shift
end

describe 'schema' do
    before(:all) do
        sql = File.read('lib/schema.sql')
        FileUtils.rm('tmp/rspec_tests.db') rescue Errno::ENOENT
        @db = SQLite3::Database.new("tmp/rspec_tests.db")
        @db.execute_batch(sql)
    end

    after(:all) do
        FileUtils.rm('tmp/rspec_tests.db') rescue Errno::ENOENT
    end

    describe "schools table" do
        it 'has correct columns' do
            columns = get_column_names('schools')
            expect(columns).to contain_exactly('id', 'name', 'min_grade', 'max_grade', 'prev_school_id', 'next_school_id')
        end
    end

    describe "teachers table" do
        it "has correct columns" do
            columns = get_column_names('teachers')
            expect(columns).to contain_exactly('id','first_name','last_name','school_id')
        end
    end

    describe "students table" do
        it "has correct columns" do
            columns = get_column_names('students')
            expect(columns).to contain_exactly('id', 'first_name', 'last_name', 'grade', 'school_id')
        end
    end

    describe "classes table" do
        it "has correct columns" do
            columns = get_column_names('classes')
            expect(columns).to contain_exactly('id', 'name', 'teacher_id')
        end
    end

    describe "tests table" do
        it "has correct columns" do
            columns = get_column_names('tests')
            expect(columns).to contain_exactly('id', 'name', 'score', 'class_id', 'student_id')
        end
    end

    describe "classes students join table" do
        it "has correct columns" do
            columns = get_column_names('classes_students')
            expect(columns).to contain_exactly('class_id', 'student_id')
        end
    end
end