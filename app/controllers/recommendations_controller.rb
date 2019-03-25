class RecommendationsController < ApplicationController
  def calculate
    calculate = Calculator.call(request.raw_post)

    unless calculate.success?
      return render json: { errors: calculate.errors },
                    status: :unprocessable_entity
    end

    render json: calculate.response, status: :ok
  end
end
