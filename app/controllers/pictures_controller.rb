class PicturesController < ApplicationController
  before_action :set_picture, only:[:edit , :edit_confirm , :show , :destroy ,:update]

  #一覧画面表示
  def index

    if params[:id]==nil
      @pictures = Picture.all.order(id: "DESC")
      @user=nil
    else
      @pictures = Picture.where(user_id: params[:id]).order(id: "DESC")
      @user=User.find(params[:id])
    end

  end
  def user_index

    if params[:id]==nil
      @pictures = Picture.all.order(id: "DESC")
      @user=nil
    else
      @pictures = Picture.where(user_id: params[:id]).order(id: "DESC")
      @user=User.find(params[:id])
    end

  end

  #新規画面表示
  def new

    if logged_in?

      if  params[:back]
        @picture=Picture.new(picture_params)
      else
        @picture=Picture.new
      end

    else
      regenerate_index("ログインしてください（投稿作業はログインユーザーのみに許可されています）。")
    end
  end

  #新規確認画面表示
  def confirm

    @picture = Picture.new(picture_params)
    @picture.user_id=current_user.id

    if @picture.invalid?
      params[:validate_err]=:on
      render 'new'
    end
  end

  #更新画面表示
  def edit
    if logged_in?
      if  params[:back]
          #「バリデーションに引っかかって戻る」場合、それまでの画面情報を変数に格納
          reset_picture
      end
    else
      regenerate_index("ログインしてください（投稿作業はログインユーザーのみに許可されています）。")
    end
  end

  def edit_confirm
    #更新画面で変更した（かもしれない）内容を、変数に格納
    reset_picture

    if @picture.invalid?
      params[:validate_err]=:on
      render 'new'
    end
  end

  #参照画面表示
  def show
  end

  #新規登録処理
  def create
    binding.pry
    @picture = Picture.new(picture_params)
    @picture.user_id=current_user.id

      binding.pry
    respond_to do |format|

      if @picture.save == true

        format.html{redirect_to pictures_path , notice: '登録に成功しました。' }
      else

        format.html{redirect_to new_picture_path , notice: '登録に失敗しました。' }
      end
    end
  end

  #更新処理
  def update

    #画面のhidden_field→params→@pictureに、更新対象項目を再セット
    reset_picture

    if  params[:picture][:del_img]=="1"
      @picture.image= nil
      @picture.image_cache = nil
    end

    respond_to do |format|

      if @picture.update(picture_params)==true
        format.html{redirect_to pictures_path , notice: '更新に成功しました。' }
      else
        format.html{redirect_to new_picture_path , notice: '更新に失敗しました。' }
      end
    end
  end

  def destroy
    if logged_in?
      @picture.destroy
      regenerate_index("投稿を削除しました。")
    else
      regenerate_index("ログインしてください（投稿作業はログインユーザーのみに許可されています）。")
    end
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  #アクション前に表示していた内容を、モデル型変数にセットし直す
  def reset_picture
      @picture.title= picture_params[:title]
      @picture.content= picture_params[:content]

      if not (picture_params[:image]==nil )
        @picture.image= picture_params[:image]
        @picture.image_cache = picture_params[:image_cache]
      end
  end

  def picture_params
    params.require(:picture).permit(:title , :content,:image,:image_cache,:remove_image)
  end

  #インデックス画面で権限がないボタンを押した場合→それまで表示していたインデックスを再表示
  def regenerate_index(msg)
    if params[:user]==nil
      redirect_to pictures_path, notice: msg
    else
      redirect_to user_index_picture_path(params[:user][:id]), notice: msg
    end
  end
end
