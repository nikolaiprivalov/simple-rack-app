RSpec.describe StaticServer do
  let(:app) { ->(_env) { [200, {}, ['app response']] } }
  let(:static_dir) { "#{Dir.pwd}/spec/fixtures/static" }
  let(:env) { Rack::MockRequest.env_for(path) }

  describe '#call' do
    subject { described_class.new(app, static_dir: static_dir).call(env) }

    context 'when requested static file exists' do
      let(:path) { '/foo.html' }

      it { is_expected.to eq [200, {}, ["bar\n"]] }
    end

    context 'when requested static file does not exist' do
      context 'when file has asset-like extention' do
        let(:path) { '/foo.css' }

        it { is_expected.to eq [404, {}, []] }
      end

      context 'when file does not have asset-like extention' do
        let(:path) { '/foo.bar' }

        it { is_expected.to eq [200, {}, ['app response']] }
      end
    end
  end
end
