RSpec.shared_context "request context", :shared_context => :metadata do
  ## Helpful for testing Rails API.
  def json
    JSON.parse(response.body)
  end
end
