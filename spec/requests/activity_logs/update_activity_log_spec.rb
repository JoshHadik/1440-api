RSpec.describe "REQUEST: Update activity log (PUT/PATCH /activity_logs/:id)", type: :request do
  let(:activity_log) { FactoryBot.create(:activity_log) }

  simulation(:update_activity_log) do |with:{}|
    json_request :put, activity_log_path(activity_log), params: {
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
    it 'does not update the activity log' do
      expect_simulation(:update_activity_log, with: valid_attributes).to_not change {
        activity_log.reload.updated_at.to_s
      }
    end

    it 'returns a status code of 401' do
      simulate(:update_activity_log, with: valid_attributes)
      expect(response.status).to be(401)
    end
  end

  context 'when the user is signed in' do
    before do
      sign_in_as_user
    end

    context 'and tries to update an activity log they do not own' do
      it 'does not update the activity log' do
        expect_simulation(:update_activity_log, with: valid_attributes).to_not change {
          activity_log.reload.updated_at.to_s
        }
      end

      it 'returns a status code of 401' do
        simulate(:update_activity_log, with: valid_attributes)
        expect(response.status).to be(401)
      end
    end

    context 'and tries to update an activity log they own' do
      before do
        activity_log.update(user: signed_in_user)
      end

      context 'with invalid attributes' do
        it 'does not update the activity log' do
          expect_simulation(:update_activity_log, with: invalid_attributes).to_not change {
            activity_log.reload.updated_at.to_s
          }
        end

        it 'returns a status code of 422' do
          simulate(:update_activity_log, with: invalid_attributes)
          expect(response.status).to be(422)
        end
      end

      context 'with valid attributes' do
        it 'updates the activity log' do
          simulate(:update_activity_log, with: valid_attributes)
          expect(activity_log.reload).to match_attributes(valid_attributes)
        end

        it 'returns a status code of 200' do
          simulate(:update_activity_log, with: valid_attributes)
          expect(response.status).to be(200)
        end
      end
    end
  end
end
