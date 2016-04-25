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
end
