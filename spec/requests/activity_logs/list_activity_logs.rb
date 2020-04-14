RSpec.describe "REQUEST: Create activity log (POST /activity_logs)", type: :request do

  simulation(:create_activity_log) do |with:|
    json_request :post, activity_logs_path, params: {
      activity_log: with
    }
    reload_user if signed_in_user
  end

  let(:valid_attributes) do
    FactoryBot.attributes_for(:activity_log).except(:user)
  end

  let(:invalid_attributes) do
    FactoryBot.attributes_for(:activity_log, :invalid).except(:user)
  end

  context 'when the user is not signed in' do
    it 'does not create an activity log' do
      expect_simulation(:create_activity_log, with: valid_attributes).to_not create_a_new(ActivityLog)
    end

    it 'returns a status code of 401' do
      simulate(:create_activity_log, with: valid_attributes)
      expect(response.status).to eq(401)
    end
  end

  context 'when the user is signed in' do
    before { sign_in_as_user }
    context 'and tries to create an activity log with invalid attributes' do
      it 'does not create the new activity log' do
        expect_simulation(:create_activity_log, with: invalid_attributes).to_not create_a_new(ActivityLog)
      end

      it 'returns a status code of 422' do
        simulate(:create_activity_log, with: invalid_attributes)
        expect(response.status).to eq(422)
      end
    end

    context 'and tries to create an activity log with valid attributes' do
      it 'creates a new activity log with expected attributes' do
        expect_simulation(:create_activity_log, with: valid_attributes).to create_a_new(ActivityLog)
        new_activity_log = signed_in_user.activity_logs.last
expect(new_activity_log).to match_attributes(valid_attributes)
      end

      it 'returns a status code of 201' do
        simulate(:create_activity_log, with: valid_attributes)
        expect(response.status).to eq(201)
      end
    end
  end
end
