RSpec.describe "REQUEST: Update activity log (PUT/PATCH /activity_logs/:id)", type: :request do
  context 'when the user is not signed in' do
    it 'does not update the activity log'
    it 'returns a status code of [XXX]'
  end

  context 'when the user is signed in' do
    context 'and tries to update an activity log they do not own' do
      it 'does not update the activity log'
      it 'returns a status code of [XXX]'
    end

    context 'and tries to update an activity log they own' do
      context 'with invalid attributes' do
        it 'does not update the activity log'
        it 'returns a status code of [XXX]'
      end
      
      context 'with valid attributes' do
        it 'updates the activity log'
        it 'returns a status code of [XXX]'
      end
    end
  end
end
