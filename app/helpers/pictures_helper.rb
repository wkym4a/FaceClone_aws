module PicturesHelper

  def get_next_url_picture(id_info,next_btn=true)
    #「next_btn」がFの場合→戻るボタンを押した場合のurlを取得する
    
    if params[:validate_err] ==nil
      #「validate_err」でない→通常に画面を開いた場合

      case action_name
      when 'new'#新規画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録前確認画面の表示」
            return confirm_pictures_path
          else
            #戻るアクションは「一覧画面」
            return pictures_path
          end

        when 'confirm'#新規登録前画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録処理」……メソットがpost
            return pictures_path
          else
            #戻るアクションは新規登録画面の表示」
            return new_picture_path
          end

        when 'edit'#更新画面を開いたなら
          if next_btn==true
            #次のアクションは「更新前確認画面の表示」
            return edit_confirm_picture_path(id_info)
          else
            #戻るアクションは「一覧画面」
            return pictures_path
          end

        when 'edit_confirm'#更新前画面を開いたなら
          if next_btn==true
            #次のアクションは「更新処理」……メソットがpatch
            return picture_path(id_info)
          else
            #戻るアクションは更新前確認画面の表示」
            return edit_picture_path(id_info)
          end

        else#取得できなかった場合、一覧に戻る（発生しないと思うが念の為
          return pictures_path
      end

    else
      #バリデーションエラーによって戻った場合

      case action_name
      when 'confirm'#「confirm」でバリd−ションエラー→新規画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録前確認画面の表示」
            return confirm_pictures_path
          else
            #戻るアクションは「一覧画面」
            return pictures_path
          end

        when 'create'#「create」でバリd−ションエラー→新規登録前画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録処理」……メソットがpost
            return pictures_path
          else
            #戻るアクションは新規登録画面の表示」
            return new_picture_path
          end

        when 'edit_confirm'#「edit_confirm」でバリd−ションエラー→更新画面を開いたなら
          if next_btn==true
            #次のアクションは「更新前確認画面の表示」
            return edit_confirm_picture_path(id_info)
          else
            #戻るアクションは「一覧画面」
            return pictures_path
          end

        when 'update'#「update」でバリd−ションエラー→更新前画面を開いたなら
          if next_btn==true
            #次のアクションは「更新処理」……メソットがpatch
            return picture_path(id_info)
          else
            #戻るアクションは新規登録前確認画面の表示」
            return edit_picture_path(id_info)
          end

        else#取得できなかった場合、一覧に戻る（発生しないと思うが念の為
          return pictures_path
      end
    end

  end

end
