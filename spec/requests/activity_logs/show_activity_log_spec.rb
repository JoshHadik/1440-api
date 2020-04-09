RSpec.describe "REQUEST: Show activity log (GET /activity_logs/:id)", type: :request do

  simulation(:show_activity_log) do |with:{}|
    json_request :get, activity_log_path(with)
  end

  let(:random_activity_log) do
    FactoryBot.create(:activity_log, user: FactoryBot.create(:user))
  end

  context 'when the user is not signed in' do
    it 'does not return the activity log' do
      simulate(:show_activity_log, with: random_activity_log)
      expect(response.body).to_not include(random_activity_log.to_json)
    end

    it 'returns a status code of 401' do
      simulate(:show_activity_log, with: random_activity_log)
      expect(response.status).to eq(401)
    end
  end

  context 'when the user is signed in' do
    before  do
      sign_in_as_user
    end

    let(:owned_activity_log) do
      FactoryBot.create(:activity_log, user: signed_in_user)
    end

    context 'and tries to get an activity log they do not own' do
      it 'does not return the activity log' do
        simulate(:show_activity_log, with: random_activity_log)
        expect(response.body).to_not include(random_activity_log.to_json)
      end

      it 'returns a status code of 401' do
        simulate(:show_activity_log, with: random_activity_log)
        expect(response.status).to eq(401)
      end
    end

    context 'and tries to get an activity log they own' do
      it 'does return the activity log' do
        simulate(:show_activity_log, with: owned_activity_log)
        expect(response.body).to include(owned_activity_log.to_json)
      end

      it 'returns a status code of 200' do
        simulate(:show_activity_log, with: owned_activity_log)
        expect(response.status).to eq(200)
      end
    end
  end
end
