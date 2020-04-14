RSpec.describe "REQUEST: Delete user registration (DELETE /users)", type: :request do
  simulation(:delete_user) do |with:{}|
    json_request :delete, user_registration_path,
  end

  context 'when user is signed in' do
    before { sign_in_as_user }

    it 'deletes the signed in user' do
      simulate(:delete_user)
      expect(signed_in_user).to be_destroyed
    end

    it 'returns status code of 204' do
      simulate(:delete_user)
      expect(response.status).to eq(204)
    end
  end

  context 'when user is not signed in' do
    it 'does not delete any users'
    it 'returns status code of 401' do
      simulate(:delete_user)
      expect(response.status).to eq(401)
    end
  end
end
