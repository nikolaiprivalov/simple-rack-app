RSpec.describe HelloWorld do
  let(:app) { described_class.new }

  describe '/' do
    subject { get '/' }

    it { expect(subject.status).to eq(200) }
    it { expect(subject.headers).to eq({}) }
    it { expect(subject.body).to include('Hello World') }
  end
end
