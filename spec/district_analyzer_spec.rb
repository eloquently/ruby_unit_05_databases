require 'district_analyzer'

db_path = 'db/seeded_test_db.sqlite3'
clean_db_path = 'db/seeded_test_db_clean.sqlite3'

describe DistrictAnalyzer do
    before :all do
        if !File.exist?(clean_db_path)
            @db = SQLite3::Database.new(clean_db_path)
            schema_sql = File.read('lib/schema.sql')
            puts "Setting up clean copy of db from schema and seed data"
            @db.execute_batch(schema_sql)
            seed_data = File.read('lib/seed_data.sql')
            puts "Seeding db... this may take a few min (and should only run once)"
            @db.execute_batch(seed_data)
            puts "Seeding complete"
        end
    end

    before :each do
        FileUtils.rm(db_path)
        FileUtils.cp(clean_db_path, db_path)
    end

    let(:district_analyzer) { DistrictAnalyzer.new(db_path) }

    describe '#count_students' do
        it 'gives correct result' do
            expect(district_analyzer.count_students).to eq(1200)
        end
    end

    describe '#count_students' do
        it 'gives correct result' do
            expect(district_analyzer.count_students_at_school(6)).to eq(200)
        end
    end

    describe '#list_teachers' do
        it 'gives correct result' do
            expect(district_analyzer.list_teachers(3)).to eq([{"first_name"=>"Daniel", "last_name"=>"Bryant", 0=>"Daniel", 1=>"Bryant"}, {"first_name"=>"Frances", "last_name"=>"Stephens", 0=>"Frances", 1=>"Stephens"}, {"first_name"=>"Margaret", "last_name"=>"Yang", 0=>"Margaret", 1=>"Yang"}, {"first_name"=>"Roy", "last_name"=>"Torres", 0=>"Roy", 1=>"Torres"}, {"first_name"=>"Randy", "last_name"=>"Cross", 0=>"Randy", 1=>"Cross"}, {"first_name"=>"Evelyn", "last_name"=>"Stevenson", 0=>"Evelyn", 1=>"Stevenson"}, {"first_name"=>"Jane", "last_name"=>"Bowers", 0=>"Jane", 1=>"Bowers"}, {"first_name"=>"Barbara", "last_name"=>"Mendoza", 0=>"Barbara", 1=>"Mendoza"}, {"first_name"=>"Jeremy", "last_name"=>"Christian", 0=>"Jeremy", 1=>"Christian"}, {"first_name"=>"Brittany", "last_name"=>"Valentine", 0=>"Brittany", 1=>"Valentine"}])
        end
    end

    describe '#teacher_info' do
        it 'gives correct result' do
            expect(district_analyzer.teacher_info(10)).to eq([{"first_name"=>"Larry", "last_name"=>"Duran", "class_name"=>"Physics", 0=>"Larry", 1=>"Duran", 2=>"Physics"}, {"first_name"=>"Larry", "last_name"=>"Duran", "class_name"=>"German", 0=>"Larry", 1=>"Duran", 2=>"German"}, {"first_name"=>"Larry", "last_name"=>"Duran", "class_name"=>"Spanish", 0=>"Larry", 1=>"Duran", 2=>"Spanish"}])
        end
    end

    describe '#class_catalog' do
        it 'gives correct result' do
            expect(district_analyzer.class_catalog(3)).to eq([["Civics"], ["English"], ["PE"], ["Calculus"], ["Chemistry"], ["Algebra"], ["Geometry"], ["History"], ["Spanish"], ["Physics"], ["Biology"], ["German"]])
        end
    end

    describe '#hardest_teachers' do
        it 'gives correct result' do
            expect(district_analyzer.hardest_teachers(2)).to eq([{"first_name"=>"Diana", "last_name"=>"Levine", "avg_test_score"=>75.65384615384616, 0=>"Diana", 1=>"Levine", 2=>75.65384615384616}, {"first_name"=>"Doris", "last_name"=>"Roach", "avg_test_score"=>76.41666666666667, 0=>"Doris", 1=>"Roach", 2=>76.41666666666667}])
        end
    end

    describe '#top_students' do
        it 'gives correct result' do
            expect(district_analyzer.top_students(3)).to eq([{"first_name"=>"Jerry", "last_name"=>"Burch", "name"=>"Phoenix Elementary School", "avg_test_score"=>94.5, 0=>"Jerry", 1=>"Burch", 2=>"Phoenix Elementary School", 3=>94.5}, {"first_name"=>"Margaret", "last_name"=>"Olsen", "name"=>"Tempe Middle School", "avg_test_score"=>93.66666666666667, 0=>"Margaret", 1=>"Olsen", 2=>"Tempe Middle School", 3=>93.66666666666667}, {"first_name"=>"Douglas", "last_name"=>"Russo", "name"=>"Phoenix Elementary School", "avg_test_score"=>93.0, 0=>"Douglas", 1=>"Russo", 2=>"Phoenix Elementary School", 3=>93.0}])
        end
    end

    describe '#bottom_students' do
        it 'gives correct result' do
            expect(district_analyzer.bottom_students(2)).to eq([{"first_name"=>"Stephen", "last_name"=>"Barajas", "name"=>"Phoenix Elementary School", "avg_test_score"=>64.33333333333333, 0=>"Stephen", 1=>"Barajas", 2=>"Phoenix Elementary School", 3=>64.33333333333333}, {"first_name"=>"Johnny", "last_name"=>"Shepard", "name"=>"Tempe High School", "avg_test_score"=>66.83333333333333, 0=>"Johnny", 1=>"Shepard", 2=>"Tempe High School", 3=>66.83333333333333}])
        end
    end
end
