require 'spec_helper_acceptance'

describe 'puppetagent class' do
  context 'should work with no errors' do
    it 'when configuring puppetagent without parameters' do
      pp = <<-EOS
        class { 'puppetagent': }
      EOS

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
        expect(r.exit_code).to eq(2)
      end

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to eq(/error/i)
        expect(r.exit_code).to be_zero
      end
    end

    describe package('puppet-agent') do
      it { is_expected.to be_installed }
    end

    describe service('puppet') do
      it { should be_enabled }
      it { should be_running }
    end

  end
end
