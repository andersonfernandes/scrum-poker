FactoryGirl.define do
  factory :task do
    title "Fix test errors"
    description "cadastrar task"
    session_vote { FactoryGirl.create(:session_vote) }
  end
end
