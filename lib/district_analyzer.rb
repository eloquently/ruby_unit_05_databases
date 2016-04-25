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

    # list a teacher's name and which classes he/she teaches given a teacher_id
    # this method should return an array with one element for each class taught
    # by the teacher. Each element should be a hash with the teacher's names and
    # the name of one of their classes.

    # e.g. [ { first_name: "Jane", last_name: "Doe", class_name: "Algebra" },
    #        { first_name: "Jane", last_name: "Doe", class_name: "Calculus" } ]
    def teacher_info(teacher_id)
    end

    # get a list of classes offered by a school.
    # this method should return an array where each element is an array with one
    # element
    # e.g. [ ["Spanish"], ["French"], ... ]
    def unique_classes(school_id)
    end

    # find the hardest n teachers in the district based on the average test
    # scores in all of their classes
    # e.g. [ { first_name: "Jane", last_name: "Doe", avg_test_score: 72 },
    #        { first_name: "John", last_name: "Smith", avg_test_score: 73 }, ... ]
    def hardest_teachers(n)
    end

    # return the top n students in the district based on their average test score
    # this method should return an array where each element is a hash
    # containing the first name, last name, and school name of the people
    # e.g. [ { first_name: "Jane", last_name: "Doe", school_name: "" },
    #        { first_name: "John", last_name: "Smith", school_name: "" }, ... ]
    def top_students(n)
    end

    # return the bottom n students in the district based on their average test
    # score this method should return an array where each element is a hash
    # containing the first name, last name, and school name of the people
    # e.g. [ { first_name: "Jane", last_name: "Doe", school_name: "" },
    #        { first_name: "John", last_name: "Smith", school_name: "" }, ... ]
    def bottom_students(n)
    end

    # At the end of the school year a few things need to happen.
    # 1) All students should be advanced one grade
    # 2) Students who have graduated from one school should be sent to the next
    #       school. Students who have graduated from high school should be
    #       removed from the database.
    # 3) All data describing which students are in which classes should be
    #       removed from the database.
    # 4) All data on tests should be removed from the database.
    # This model does not need to return anything -- check the tests for
    # the postconditions of this function
    def end_year_update
    end

end