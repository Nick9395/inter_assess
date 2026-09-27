class QuestionMaster
  ITEMS = [
    { key: "self_intro", text: "自己紹介をしてください。%{profile_hint}" },
    { key: "effort", text: "学生時代、またはこれまでの仕事で力を入れたことを教えてください。%{profile_hint}" },
    { key: "strength", text: "あなたの強みを、具体的な経験と結びつけて教えてください。%{profile_hint}" },
    { key: "weakness", text: "弱みや課題と、それにどう向き合っているかを教えてください。%{profile_hint}" },
    { key: "motivation", text: "志望動機を、これまでの学びや経験と結びつけて話してください。%{profile_hint}" },
    { key: "failure", text: "失敗した経験と、そこから得た学びを教えてください。%{profile_hint}" },
    { key: "teamwork", text: "チームで成果を出した経験を教えてください。%{profile_hint}" },
    { key: "hardship", text: "困難な状況をどう乗り越えたか、具体的に教えてください。%{profile_hint}" },
    { key: "growth", text: "今後どのように成長したいかを教えてください。%{profile_hint}" },
    { key: "closing", text: "最後に、伝えておきたいことがあればどうぞ。%{profile_hint}" }
  ].freeze

  def self.size
    ITEMS.size
  end

  def self.sample(count)
    ITEMS.sample(count)
  end
end
