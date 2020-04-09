# RSpec.describe "REQUEST: Create user session (POST /users/sign_in)", type: :request do
#   simulation(:user_sign_in) do |with:{}|
#     post user_session_path(params: with)
#   end
#
#   let(:user_attributes) do
#     FactoryBot.attributes_for(:user)
#   end
#
#   let!(:user) do
#     FactoryBot.create(:user, user_attributes)
#   end
#
#   let(:valid_credentials) do
#     { user: user_attributes.without(:password_confirmation) }
#   end
#
#   let(:invalid_credentials) do
#     valid_credentials[:user].merge(password: nil)
#   end
#
#   context 'when user is not signed in' do
#     context 'and signs in with correct email and password' do
#       it 'signs the user in'
#       it 'returns status of 201'
#     end
#
#     context 'and signs in with invalid attributes' do
#       it 'does not sign the user in'
#       it 'returns a status of 401'
#     end
#   end
#
#   context 'when user is already signed in' do
#     before { sign_in_as_user }
#
#     it 'does not change the session\'s user id'
#     it 'returns a status of 201'
#   end
# end
