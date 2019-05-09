class SessionsController < ApplicationController

  #ログイン画面表示
  def new
  end

  #ログイン時処理
  def create
    user=User.find_by(email: params[:session][:email].downcase)

    #メールアドレスに対応するユーザーがない場合はエラーを出して抜ける
    if user==nil
      flash[:danger] = 'メールアドレスが不正です。'
      render 'new'

    #パスワードが違う場合はエラーにして抜ける
    elsif user.authenticate(params[:session][:password]) == false

        flash[:danger] = 'パスワードが間違っています。'
        render 'new'
    else
      #パスワードが合っていた場合→ユーザーのidを保存→ログイン
      session[:user_id]=user.id

      respond_to do |format|
        format.html{redirect_to user_path(current_user) , notice: "ログインしました" }
      end
      #redirect_to user_path(user.id) どっちも同じ？
    end

  end

  #ログアウト時処理
  def destroy
    session.delete(:user_id)

    respond_to do |format|
      format.html{redirect_to new_session_path , notice: "ログアウトしました" }
    end
  end
end
