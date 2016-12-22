require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) { User.delete_all }

  describe '#authenticator=' do

    context 'with local' do
      it do
        expect(User.create(authenticator: 'local', password: 'foobarbarz')).to be_valid
      end
    end

    context 'others' do
      it do
        expect(User.create(authenticator: 'foo')).not_to be_valid
      end
    end

  end

  describe '#password=' do

    context 'with valid length' do
      it do
        expect(User.create(authenticator: 'local', password: 'foobar')).to be_valid
      end
    end

    context 'shorther length' do
      it do
        expect(User.create(authenticator: 'local', password: 'foo')).not_to be_valid
      end
    end

    context 'longer length' do
      it do
        expect(User.create(authenticator: 'local', password: 'f' * 1000)).not_to be_valid
      end
    end

  end

  describe '#encrypt_password' do
    it do
      user = User.create(authenticator: 'local', password: 'foobar')
      expect(user.salt).to be_present
      expect(user.encrypted_password).to be_present
    end
  end

  describe '#clear_password' do
    it do
      user = User.create(authenticator: 'local', password: 'foobar')
      expect(user.password).to be_nil
    end
  end

  describe '#match_password?' do
    let(:password) { 'foobar' }
    let(:user) { User.create(authenticator: 'local', password: password) }

    context 'with valid password' do
      it do
        expect(user.match_password?(password)).to be_truthy
      end
    end

    context 'with invalid password' do
      it do
        expect(user.match_password?('something_wrong')).to be_falsey
      end
    end
  end

  describe '#authenticate' do
    let(:username) { 'foobar' }
    let(:password) { 'foobar' }
    let(:user) { User.create(name: username, authenticator: 'local', password: password) }

    before { user }

    context 'with valid name, password' do
      it do
        expect(User.authenticate(username: username, password: password).class).to eql(User)
      end
    end

    context 'with invalid name' do
      it do
        expect(User.authenticate(username: 'something_wrong', password: password)).to be_falsey
      end
    end

    context 'with invalid password' do
      it do
        expect(User.authenticate(username: username, password: 'something_wrong')).to be_falsey
      end
    end
  end

  describe '#find_by_access_token' do
    before do
      @user = User.create(name: 'foobar', authenticator: 'local', password: 'foobar')
      @api_key = ApiKey.create(user_id: @user.id)
    end

    it do
      user = User.find_by_access_token(@api_key.access_token)
      expect(user.id).to eql(@user.id)
    end
  end

  describe '#invalidate_api_keys' do
    before do
      @user = User.create(name: 'foobar', authenticator: 'local', password: 'foobar')
      @api_key = ApiKey.create(user_id: @user.id)
      @user.destroy
    end

    it do
      user = User.find_by_access_token(@api_key.access_token)
      expect(user).to be_nil
    end
  end
end
