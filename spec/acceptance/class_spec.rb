require 'spec_helper_acceptance'

describe 'nginx class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'nginx is expected run successfully' do
    pp = "class { 'nginx': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be_zero
    end
  end

  context 'repo_manage => present:' do
    it 'runs successfully to ensure package is installed from custom repo' do
      pp = "class { 'nginx': repo_manage => true }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'package_ensure => present:' do
    it 'runs successfully to ensure package is installed' do
      pp = "class { 'nginx': package_ensure => present }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'service_ensure => running:' do
    it 'starts the service successfully' do
      pp = "class { 'nginx': service_ensure => running }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'service_ensure => stopped:' do
    it 'stops the service successfully' do
      pp = "class { 'nginx': service_ensure => stopped }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'firewall_manage => true:' do
    it 'runs successfully' do
      pp = "class { 'nginx': firewall_manage => true }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'package_ensure => absent:' do
    it 'runs successfully to ensure package is uninstalled' do
      pp = "class { 'nginx': package_ensure => absent, service_manage => false }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end
end
