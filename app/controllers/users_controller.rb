class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save == true
        #ユーザー登録に成功した場合、登録した自身のidを投げることで参照画面に飛ぶ
        format.html{redirect_to user_path(@user.id) , notice: "ユーザー情報を登録しました。" }

      else
        #失敗した場合、新規登録画面に戻る
        format.html{render :new}

      end
    end

  end

  private

  def user_params
    params.require(:user).permit(:name , :email ,
                                 :password , :password_confirmation)
  end

end
