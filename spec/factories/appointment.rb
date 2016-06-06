FactoryGirl.define do
  factory :appointment do
    first_name "factory"
    last_name "girl"
    start_time "11/18/16 14:45"
    end_time "11/18/16 14:50"
    day { "#{start_time.split[0]}" }
  end
  # factory :appointment_1 do
  #   first_name "blah"
  #   last_name "test"
  #   start_time "11/18/17 14:45"
  #   end_time "11/18/17 14:50"
  # end
  # factory :appointment_double_name do
  #   first_name "blah"
  #   last_name "test"
  #   start_time "12/18/17 14:45"
  #   end_time "12/18/17 14:50"
  # end
  # factory :appointment_double_day do
  #   first_name "not"
  #   last_name "first"
  #   start_time "11/18/17 1:45"
  #   end_time "11/18/17 1:50"
  # end
  # factory :appointment_2 do
  #     first_name "not"
  #     last_name "girl"
  #     start_time "11/18/17 1:45"
  #     end_time "11/18/17 1:50"
  # end

end
