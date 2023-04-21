# カードのクラスを定義
class Card
  # インスタンス変数suit（カードのマーク）、value（カードの数字）の読み取り専用アクセサを設定
  attr_reader :suit, :value

  # それぞれのインスタンス変数に初期値を設定
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  # suitとvalueの文字列を返すメソッド
  def to_s
    "#{suit}の#{value}"
  end

  # カードのポイントを返すメソッド
  def point
    case value
    # Aのときは1点
    when 'A'
      1
    when 'J', 'Q', 'K'
      10
    else
      value.to_i
    end
  end
end

# カードの山札のクラスを定義
class Deck

  # マークと数の定数を定義
  SUITS = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
  VALUES = [*'2'..'10', 'J', 'Q', 'K', 'A']

  def initialize
    # SUITSとVALUES の全ての組み合わせを生成して、各組み合わせに対してCardオブジェクトを作成。
    # その後カードをシャッフルしてインスタンス変数に格納
    @cards = SUITS.product(VALUES).map { |suit, value| Card.new(suit, value) }.shuffle
  end

  # カードを1枚引く
  def draw
    @cards.pop
  end
end

# 手札のクラスを定義
class Hand

  # 空のカード配列をインスタンス変数として作成（手札）
  def initialize
    @cards = []
  end

  # カードを手札に追加
  def add_card(card)
    @cards << card
  end

  def to_s
    # @cards配列内の各カードの文字列をカンマで区切って結合
    @cards.map(&:to_s).join(', ')
  end

  # 手札のスコアを計算
  def score
    # @cards配列内の各カードのポイントを合計
    sum = @cards.sum(&:point)
    sum
  end
end

# プレーヤーのクラスを定義
class Player

  # インスタンス変数handの読み取り専用アクセサを設定
  attr_reader :hand

  def initialize
    # Handオブジェクトを作成してインスタンス変数に設定
    @hand = Hand.new
  end

  # 山札からカードを1枚引く
  def draw(deck)
    card = deck.draw
    @hand.add_card(card)
    card
  end
end

# 新規インスタンス作成
deck = Deck.new
player = Player.new
dealer = Player.new

puts "ブラックジャックを開始します。"

# プレーヤーが最初に引く2枚
2.times do
  player_card = player.draw(deck)
  puts "あなたの引いたカードは#{player_card}です。"
end

# ディーラーの1枚めのカード
dealer_card = dealer.draw(deck)
puts "ディーラーの引いたカードは#{dealer_card}です。"
dealer.draw(deck)

# プレーヤーの引いたカードの合計値を出して、さらに引くか選択させる
loop do
  puts "あなたの現在の得点は#{player.hand.score}です。カードを引きますか？（Y/N）"
  input = gets.chomp

  if input.upcase == 'Y'
    player_card = player.draw(deck)
    puts "あなたの引いたカードは#{player_card}です。"
    if player.hand.score > 21
      puts "あなたの現在の得点は#{player.hand.score}です。"
      puts "あなたの負けです。"
      break
    end
  else
    break
  end
end

# プレーヤーの引いたカードの合計が21以下の処理
if player.hand.score <= 21
  puts "ディーラーの引いた2枚目のカードは#{dealer.hand.to_s.split(', ')[1]}でした。"
  while dealer.hand.score < 17
    dealer_card = dealer.draw(deck)
    puts "ディーラーの引いたカードは#{dealer_card}です。"
  end

  puts "あなたの得点は#{player.hand.score}です。"
  puts "ディーラーの得点は#{dealer.hand.score}です。"

  if dealer.hand.score > 21
    puts "あなたの勝ちです！"
  elsif player.hand.score > dealer.hand.score
    puts "あなたの勝ちです！"
  elsif player.hand.score < dealer.hand.score
    puts "あなたの負けです。"
  else
    puts "引き分けです。"
  end

end
  
puts "ブラックジャックを終了します。"
