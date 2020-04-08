RSpec.describe "REQUEST: Destroy activity log (DELETE /activity_logs/:id)", type: :request do
  context 'when the user is not signed in' do
    it 'does not destroy the activity log'
    it 'returns a status code of [XXX]'
  end

  context 'when the user is signed in' do
    context 'and tries to destroy an activity log they do not own' do
      it 'does not destroy they activity log'
      it 'returns a status code of [XXX]'
    end

    context 'and tries to destroy an activity log they own' do
      it 'destroys the activity log'
      it 'returns a status code of [XXX]'
    end
  end
end
