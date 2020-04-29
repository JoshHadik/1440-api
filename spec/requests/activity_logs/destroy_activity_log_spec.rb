RSpec.describe "REQUEST: Destroy activity log (DELETE /activity_logs/:id)", type: :request do
  simulation(:destroy_activity_log) do
    json_request :delete, activity_log_path(activity_log)
    reload_user if signed_in_user
  end

  let(:activity_log) do
    FactoryBot.create(:activity_log)
  end

  context 'when the user is not signed in' do
    it 'returns a status code of 401' do
      simulate(:destroy_activity_log, with: activity_log)
      expect(response.status).to be(401)
    end

    it 'does not destroy the activity log' do
      expect_simulation(:destroy_activity_log, with: activity_log).to_not change(ActivityLog, :count)
      expect(ActivityLog.exists?(activity_log.id)).to be(true)
    end
  end

  context 'when the user is signed in' do
    before do
      sign_in_as_user
    end

    context 'and tries to destroy an activity log they do not own' do
      it 'returns a status code of 401' do
        simulate(:destroy_activity_log, with: activity_log)
        expect(response.status).to be(401)
      end

      it 'does not destroy the activity log' do
        expect_simulation(:destroy_activity_log, with: activity_log).to_not change(ActivityLog, :count)
        expect(ActivityLog.exists?(activity_log.id)).to be(true)
      end
    end

    context 'and tries to destroy an activity log they own' do
      before do
        activity_log.update(user: signed_in_user)
      end

      it 'returns a status code of 204' do
        simulate(:destroy_activity_log, with: activity_log)
        expect(response.status).to eq(204)
      end

      it 'destroys the activity log' do
        expect_simulation(:destroy_activity_log, with: activity_log).to change(ActivityLog, :count).by(-1)
        expect(ActivityLog.exists?(activity_log.id)).to be(false)
      end
    end
  end
end
