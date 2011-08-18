# -*- coding: utf-8 -*-
require 'pebbles'
include Pebbles

class Pebbles::AntiHangover
  VERSION = '0.1.0'

  ALCOHOL_TYPE = {
    beer: {
      name:         'ビール',
      glass:        'レギュラー缶',
      unit:         '本',
      alcoholicity:   5,
      net:          350,
    },
    chuhi: {
      name:         '酎ハイ',
      glass:        'サワーグラス',
      unit:         '杯',
      alcoholicity:   7,
      net:          200,
    },
    sake: {
      name:         '日本酒',
      glass:        '小徳利',
      unit:         '本',
      alcoholicity:  12,
      net:          180,
    },
    wine: {
      name:         'ワイン',
      glass:        'ワイングラス',
      unit:         '杯',
      alcoholicity:  15,
      net:          120,
    },
    shochu: {
      name:         '焼酎',
      glass:        '焼酎グラス',
      unit:         '杯',
      alcoholicity:  25,
      net:           60,
    },
    whiskey: {
      name:         'ウイスキー',
      glass:        'ショットグラス',
      unit:         '杯',
      alcoholicity:  40,
      net:           40,
    },
  }

  def initialize drunker_weight, drinking_hours
    @drunker_weight = drunker_weight
    @drinking_hours = drinking_hours
    raise ArgumentError unless @drunker_weight > 0
    raise ArgumentError unless @drinking_hours > 0
    @drunk_glasses = Hash[ALCOHOL_TYPE.keys.zip(Array.new(ALCOHOL_TYPE.count).fill(0))]
  end

  def permissible_alcohol
    (15 * @drunker_weight * @drinking_hours / 80).round
  end

  def drink kind, glasses = 1
    raise ArgumentError unless ALCOHOL_TYPE.include?(kind)
    @drunk_glasses[kind] += glasses
  end

  def total_drunk
    @drunk_glasses.inject(0) do |total, drunk|
      glass = ALCOHOL_TYPE[drunk.first]
      total + (drunk.last * glass[:alcoholicity] * glass[:net] / 100.0).round
    end
  end

  def hangover?
    total_drunk > permissible_alcohol
  end

  def dump
    result = "体重#{@drunker_weight}kgのあなたは、\n"
    drunk_logs = ''
    @drunk_glasses.each do |kind, glasses|
      drunk_logs += "、\n" unless drunk_logs.empty?
      glass = ALCOHOL_TYPE[kind]
      drunk_logs += "#{glass[:name]}を#{glass[:glass]}に#{glasses}#{glass[:unit]}"
    end
    result += drunk_logs + "飲んで、\n#{@drinking_hours}時間後に起きなければなりません。\n\n"
    result += 'そのときあなたは、おそらく二日酔いに'
    result += "#{hangover? ? 'なる' : 'ならない'}でしょう。\n" ;
    result
  end
end
