class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_instructor
rescue_from ActiveRecord::RecordNotFound, with: :not_found_instructor
    def index
    instructors = Instructor.all
        render json: instructors
    end

    def show
    instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: :created
    end

    def update
        update_instructor = Instructor.find(params[:id])
        update_instructor.update!(instructor_params)
        render json: update_instructor
    end

    def destroy
        delete_instructor = Instructor.find(params[:id])
        delete_instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end


    def not_found_instructor
        render json: { error: "Instructor not found!" }, status: :not_found
    end
    
    def invalid_instructor(error_hash)
        render json: { errors: error_hash.record.errors.full_messages}, status: :unprocessable_entity
    end
end
