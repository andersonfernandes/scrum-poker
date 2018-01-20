require 'rails_helper'

describe RoomsController, '#vote', type:[:controller, :room] do
  let(:user) { create(:user) }
  let(:card) { create(:card) }
  let(:task) { create(:task) }
  let(:step) { create(:step)}
  let(:session_vote) { create(:session_vote) }

  before do
    session_vote
    sign_in user
    action
  end

  let(:action) { get :vote, params: {id: session_vote.id, card_id: card.id, task_id: task.id, step_id: step.id }, xhr: true }

  context 'When user access #vote with valid params' do
    it 'should return status 200' do
      expect(response.status).to be == 200
    end

    it 'should render :save_success' do
      expect(subject).to render_template :vote_success
    end

    it "creates a new vote" do
      expect{
        get :vote, params:{ id: session_vote.id, card_id: card.id, task_id: task.id, step_id: step.id }, xhr:true
      }.to change(Vote, :count).by(1)
    end
  end
end
