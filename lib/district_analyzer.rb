require 'sqlite3'

class DistrictAnalyzer
    attr_accessor :path_to_db

    def initialize(path_to_db)
        self.path_to_db = path_to_db
    end

    def query(q, results_as_hash=true)
        db = SQLite3::Database.new(path_to_db)
        db.results_as_hash = results_as_hash
        result = db.execute(q)
        db.close
        return result
    end

    # count how many students are in the district
    # should return an integer
    def count_students
        query = <<-SQL
        SELECT
            COUNT(*)
        FROM
            students;
        SQL
        result = query(query, false)
        return result[0][0]
    end

    # count how many students are at a particular school
    # should return an integer
    def count_students_at_school(school_id)
    end

    # get a list of all teachers' first and last names that teach at school id
    # this method should return an array where each element is a hash
    # containing the first name and last name of the people of interest
    # e.g. [ { first_name: "Jane", last_name: "Doe" },
    #        { first_name: "John", last_name: "Smith" }, ... ]
    def list_teachers(school_id)
    end

    # get a list of all the classes taught by a particular teacher.
    # this method should return an array whtere each element is a hash
    # containing the first name of the teacher, last name of the teacher,
    # and the name of one of the teachers' classes
    # e.g. [ { first_name: "Jane", last_name: "Doe", class_name: "English" },
    #        { first_name: "John", last_name: "Smith", class_name: "Spanish" },
    #        ... ]
    def teacher_info(teacher_id)
    end

    # get a list of classes offered by a school.
    # this method should return an array where each element is an array with one
    # element
    # e.g. [ ["Spanish"], ["French"], ... ]
    def class_catalog(school_id)
    end

     # find the hardest n teachers in the district based on the average test
    # scores in all of their classes
    # e.g. [ { first_name: "Jane", last_name: "Doe", avg_test_score: 65 },
    #        { first_name: "Jane", last_name: "Doe", avg_test_score: 65 }, ... ]
    def hardest_teachers(n)
    end

    # return the top n students in the district based on their average test
    # score this method should return an array where each element is a hash
    # containing each student's first name, last name, school name, and score
    # e.g. [ { first_name: "Jane", last_name: "Doe",
    #          school_name: "Tempe High School", avg_test_score: 99 },
    #        { first_name: "Cindy", last_name: "Doe",
    #          school_name: "Tempe Middle School", avg_test_score: 95 }, ... ]
    def top_students(n)
    end

    # return the bottom n students in the district based on their average test
    # score this method should return an array where each element is a hash
    # containing the first name, last name, and school name of the people
    # e.g. [ { first_name: "Jane", last_name: "Doe", school_name: "" },
    #        { first_name: "John", last_name: "Smith", school_name: "" }, ... ]
    def bottom_students(n)
    end

    # at the end of the school year a few things need to happen.
    # 1) All students should be advanced one grade
    # 2) Students who have graduated from one school should be sent to the next
    #       school. Students who have graduated from high school should be
    #       removed from the database.
    # 3) All data describing which students are in which classes should be
    #       removed from the database.
    # 4) All data on tests should be removed from the database.
    # this method does not need to return anything.

    # write your own tests for this method using SQL queries to ensure
    # that all the conditions are met.
    def year_end_updates
    end
end