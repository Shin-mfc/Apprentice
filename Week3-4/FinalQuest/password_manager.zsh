# ファイル名の設定
password_file="passwords.txt"

echo "パスワードマネージャーへようこそ！"

# サービス名の入力
echo "サービス名を入力してください："
read service_name

# ユーザー名の入力
echo "ユーザー名を入力してください："
read user_name

# パスワードの入力
echo "パスワードを入力してください："
read -s password

# 情報をファイルに保存
echo "${service_name}:${user_name}:${password}" >> $password_file

# 完了メッセージ
echo "Thank you!"
