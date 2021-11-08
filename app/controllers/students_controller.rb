class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_student
rescue_from ActiveRecord::RecordNotFound, with: :not_found_student
    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: :created
    end

    def update
        update_student = Student.find(params[:id])
        update_student.update!(student_params)
        render json: update_student
    end

    def destroy
        delete_student = Student.find(params[:id])
        delete_student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end


    def not_found_student
        render json: { error: "Student not found!" }, status: :not_found
    end
    
    def invalid_student(error_hash)
        render json: { errors: error_hash.record.errors.full_messages}, status: :unprocessable_entity
    end
    
end
