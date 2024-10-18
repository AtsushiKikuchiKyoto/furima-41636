require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録できる' do
    it 'ユーザー登録ができる' do
      expect(@user).to be_valid
    end
  end
  context 'ユーザー新規登録できない' do
    it 'ニックネームが空ではユーザー登録ができない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'メールアドレスが空ではユーザー登録ができない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'メールアドレスが既に登録されていてはユーザー登録ができない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include 'Email has already been taken'
    end
    it 'メールアドレスに@がなければユーザー登録ができない' do
      @user.email = 'abcde12345.com'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end
    it 'パスワードが空ではユーザー登録ができない' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'パスワードが5文字以下ではユーザー登録ができない' do
      @user.password = '1b345'
      @user.password_confirmation = '1b345'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end
    it 'パスワードが英数混合(数字だけ)でなければユーザー登録ができない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
    end
    it 'パスワードが英数混合(英字だけ)でなければユーザー登録ができない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
    end
    it 'パスワードが全角ではユーザー登録ができない' do
      @user.password = 'ＡＢＣ１２３'
      @user.password_confirmation = 'ＡＢＣ１２３'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
    end
    it 'パスワードとパスワード確認が同じでなければユーザー登録ができない' do
      @user.password =              'ab5def'
      @user.password_confirmation = 'ab8def'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it '姓がなければユーザー登録ができない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it '名がなければユーザー登録ができない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it '姓は全角入力(漢字、ひらがな、カタカナ)でなければユーザー登録ができない' do
      @user.last_name = 'Yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name 全角文字を使用してください'
    end
    it '名は全角入力(漢字、ひらがな、カタカナ)でなければユーザー登録ができない' do
      @user.first_name = 'Taro'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name 全角文字を使用してください'
    end
    it 'セイがなければユーザー登録ができない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it 'メイがなければユーザー登録ができない' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana 全角カナ文字を使用してください'
    end
    it 'セイは全角入力(カタカナ)でなければユーザー登録ができない' do
      @user.last_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name kana 全角カナ文字を使用してください'
    end
    it 'メイは全角入力(カタカナ)でなければユーザー登録ができない' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana 全角カナ文字を使用してください'
    end
    it '生年月日が空ではユーザー登録ができない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end
  end
end
