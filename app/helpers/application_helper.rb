module ApplicationHelper
  def sport_icon(sport_definition)
    sport = sport_definition.to_s.downcase

    icon =
      if sport.match?(/football|soccer/)
        "⚽"
      elsif sport.match?(/basketball/)
        "🏀"
      elsif sport.match?(/rugby/)
        "🏉"
      elsif sport.match?(/tennis/)
        "🎾"
      elsif sport.match?(/running|track|athletics|jog/)
        "🏃"
      elsif sport.match?(/cycling|bike/)
        "🚴"
      elsif sport.match?(/swim/)
        "🏊"
      elsif sport.match?(/gym|strength|weight|lifting/)
        "🏋️"
      elsif sport.match?(/golf/)
        "⛳"
      elsif sport.match?(/boxing/)
        "🥊"
      elsif sport.match?(/martial|karate|judo|taekwondo/)
        "🥋"
      elsif sport.match?(/cricket/)
        "🏏"
      elsif sport.match?(/hockey/)
        "🏒"
      else
        "🏅"
      end

    tag.span(icon, class: "sport-icon", aria: { hidden: true })
  end
end