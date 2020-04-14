RSpec.describe "REQUEST: Show activity log (GET /activity_logs/:id)", type: :request do

  simulation(:show_day) do |date:|
    json_request :get, day_path(date.to_s)
  end

  let(:today) do
    Date.today
  end

  context 'when the user is not signed in' do
    it 'returns a status code of 401' do
      simulate(:show_day, date: today)
      expect(response.status).to eq(401)
    end
  end

  context 'when the user is signed in' do
    before  do
      sign_in_as_user
    end

    let!(:accessible_activity_logs) do
      [
        FactoryBot.create(:activity_log, user: signed_in_user, date: today),
        FactoryBot.create(:activity_log, user: signed_in_user, date: today)
      ]
    end

    let!(:inaccessible_activity_logs) do
      [
        FactoryBot.create(:activity_log, date: today),
        FactoryBot.create(:activity_log, user: signed_in_user, date: today - 1),
        FactoryBot.create(:activity_log, user: signed_in_user, date: today + 1)
      ]
    end

    it 'returns a status code of 200' do
      simulate(:show_day, date: today)
      expect(response.status).to eq(200)
    end

    it 'returns the activities logs owned by the user for the specified date' do
      simulate(:show_day, date: today)
      accessible_activity_logs.each do |activity_log|
        expect(response.body).to include(activity_log.to_json)
      end
    end

    it 'does not return activity logs on different days or for different users' do
      simulate(:show_day, date: today)
      inaccessible_activity_logs.each do |activity_log|
        expect(response.body).to_not include(activity_log.to_json)
      end
    end
  end
end
