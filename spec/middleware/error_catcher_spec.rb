RSpec.describe ErrorCatcher do
  let(:env) { Rack::MockRequest.env_for('/foo.bar') }

  describe '#call' do
    subject { described_class.new(app).call(env) }

    context 'when app responds with 200' do
      let(:app) { ->(_env) { [200, {}, ['app response']] } }

      it { is_expected.to eq [200, {}, ['app response']] }
    end

    context 'when app responds with 404' do
      # this looks ugly :(
      let(:app) do
        lambda { |env|
          case env['PATH_INFO']
          when '/foo.bar' then [404, {}, []]
          when '/404.html' then [200, {}, ['404 static']]
          end
        }
      end

      it { is_expected.to eq [200, {}, ['404 static']] }
    end

    context 'when app responds with 500' do
      let(:app) do
        lambda { |env|
          case env['PATH_INFO']
          when '/foo.bar' then raise
          when '/500.html' then [200, {}, ['500 static']]
          end
        }
      end

      it { is_expected.to eq [200, {}, ['500 static']] }
    end
  end
end
