class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    success_callback = lambda { |url, feed| puts url, feed }
    failure_callback = lambda { |curl, err| puts curl, err }
    Feedjira::Feed.fetch_and_parse record, on_success: success_callback, on_failure: failure_callback

    binding.pry    
  end 
end