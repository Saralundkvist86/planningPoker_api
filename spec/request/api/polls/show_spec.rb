RSpec.describe 'GET /api/polls', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:poll) { create(:poll) }

  describe 'visitor can see specific poll' do
    before do
      get "/api/polls/#{poll.id}",
          headers: headers
    end

    it 'responds with ok status' do
      expect(response).to have_http_status :ok
    end
    it 'returns a specific poll title' do
      expect(response_json['poll']['title']).to eq 'MyTitle'
    end
    it 'returns a specific poll description' do
      expect(response_json['poll']['description']).to eq 'MyDescription'
    end
    it 'returns a specific poll tasks' do
      expect(response_json['poll']['tasks']).to eq 'MyTasks'
    end
    it 'returns a specific poll state' do
      expect(response_json['poll']['state']).to eq 'ongoing'
    end
    it 'returns team for specific poll' do
      expect(response_json['poll']['team']).to eq %w[teamMember1 teamMember2]
    end
  end

  describe 'request with wrong id fails' do
    before do
      get '/api/polls/wrongId',
          headers: headers
    end
    it 'responds with not found status' do
      expect(response).to have_http_status :not_found
    end
    it 'returns error message' do
      expect(response_json['error_message']).to eq 'Sorry, that poll does not exist'
    end
  end
end
