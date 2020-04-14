RSpec.describe "REQUEST: Create user registration (POST /users)", type: :request do
  let(:valid_attributes) do
    FactoryBot.attributes_for(:user)
  end

  let(:invalid_attributes) do
    FactoryBot.attributes_for(:user, password: nil)
  end

  simulation(:create_user) do |with:|
    json_request :post, user_registration_path, params: { user: with }
  end

  context 'when user is not signed in' do
    context 'and signs up with valid attributes' do
      it 'creates a new user' do
        expect { simulate(:create_user, with: valid_attributes) }
        .to change(User,:count).by(1)
        expect(User.last.email).to eq(valid_attributes[:email])
        expect(User.last.encrypted_password).to_not be(nil)
      end

      it 'returns a status code of 201' do
        simulate(:create_user, with: valid_attributes)
        expect(response.status).to eq(201)
      end
    end

    context 'and signs up with invalid attributes' do
      it 'does not create a new user' do
        expect {
          simulate(:create_user, with: invalid_attributes)
        }.to_not change(User,:count)
      end

      it 'returns a status code of 422' do
        simulate(:create_user, with: invalid_attributes)
        expect(response.status).to eq(422)
      end
    end
  end

  context 'when user is already signed in'
end
