require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#create' do
    it '名前、メールアドレス、パスワードがあれば有効なこと' do
      user = build(:user)
      expect(user).to be_valid
    end

    it '名前が空なら無効なこと' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください') 
    end

    it 'メールアドレスが空なら無効' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください') 
    end

    it '不正なメールアドレスなら無効なこと' do
      user = build(:user, email: 'aaa')
      user.valid?
      expect(user.errors[:email]).to include('は不正な値です')
    end

    it '形式が正しいメールアドレスなら有効なこと' do
      user = build(:user, email: 'username@example.com')
      user.valid?
      expect(user).to be_valid
    end

    it '重複しているメールアドレスは無効なこと' do
      FactoryBot.create(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します') 
    end

    it 'パスワードが空なら無効なこと' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください') 
    end

    it 'パスワードが6文字未満なら無効なこと' do
      user = build(:user, password: 'abc')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください') 
    end

    it 'パスワードが6文字以上なら有効なこと' do
      user = build(:user, password: 'foobar')
      expect(user).to be_valid
    end

    it '確認パスワードが異なる場合は無効なこと' do
      user = build(:user, password_confirmation: 'foobas')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません') 
    end
  end

  describe "タイムライン" do
    let!(:user1) { FactoryBot.create(:user, :with_posts) }
    let!(:user2) { FactoryBot.create(:user, :with_posts) }
    let!(:user3) { FactoryBot.create(:user, :with_posts) }
    let!(:active) { user1.active_relationships.create(followed_id: user2.id) }

    it "フォロー中のユーザーの投稿があること" do
      user1.posts.each do |post_following|
      expect(user1.feed).to include(post_following)
      end
    end

    it "自分の投稿があること" do
      user1.posts.each do |post_self|
      expect(user1.feed).to include(post_self)
      end
    end

    it "フォロー外のユーザーの投稿がないこと" do
      user3.posts.each do |post_unfollowed|
      expect(user1.feed).not_to include(post_unfollowed)
      end
    end
  end
end
