# frozen_string_literal: true

namespace :promotion_code do
  desc 'プロモーションコード(英数字7文字) 10個の作成'
  task generate: :environment do
    10.times do |i|
      PromotionCode.create!(
        code: [*'a'..'z', *'A'..'Z', *0..9].sample(7).join,
        discount: (i + 1) * 100
      )
    end
  end
end
