# ファイル名の設定
password_file="passwords.txt"

function add_password {
  echo "サービス名を入力してください："
  read service_name
  echo "ユーザー名を入力してください："
  read user_name
  echo "パスワードを入力してください："
  read -s password
  echo "${service_name}:${user_name}:${password}" >> $password_file
  echo "パスワードの追加は成功しました。"
}

function get_password {
  echo "サービス名を入力してください："
  read service_name
  result=$(grep "^${service_name}:" $password_file)
  if [ -z "$result" ]; then
    echo "そのサービスは登録されていません。"
  else
    IFS=":" read -ra arr <<< "$result"
    echo "サービス名：${arr[0]}"
    echo "ユーザー名：${arr[1]}"
    echo "パスワード：${arr[2]}"
  fi
}

echo "パスワードマネージャーへようこそ！"

while true; do
  echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
  read choice

  case $choice in
    "Add Password")
      add_password
      ;;
    "Get Password")
      get_password
      ;;
    "Exit")
      echo "Thank you!"
      break
      ;;
    *)
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      ;;
  esac
done
