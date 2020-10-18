RSpec.describe RequestLogger do
  let(:app) { ->(_env) { [200, {}, ['app response']] } }
  let(:env) { Rack::MockRequest.env_for('/foo.bar') }
  let(:logger) { double('logger double') }

  describe '#call' do
    subject { described_class.new(app, logger: logger).call(env) }

    it 'logs incoming requests and outgoing responses' do
      expect(logger).to receive(:info).with('-> | GET | /foo.bar')
      expect(logger).to receive(:info).with('<- | 200 | /foo.bar')
      subject
    end
  end
end
