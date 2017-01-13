module ApiHelpers
  include Rack::Test::Methods
  include FactoryGirl::Syntax::Methods

  def json_response
    JSON.parse(response.body)
  end

  shared_context 'create basic master data' do
    before do
    end
  end

  shared_context 'api access_key secret_key' do
    before(:each) do
      header('X-Http-Access-Key', '2sfsafas')
      header('X-Http-Secret-Key', 'fsfafsk29fjsdfa')
    end
    subject { eval("#{method}(url, parameters, rack_env)") }
  end

end
