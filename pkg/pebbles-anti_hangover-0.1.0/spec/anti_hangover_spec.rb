# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe AntiHangover do
  # コンストラクタ
  #     体重と起きるまでの時間を受け取る
  #     総摂取可能アルコール量(ml)を算出
  describe '#initialize' do
    context '64kg drunker wakes 8hour later' do
      subject { @anti_hangover = AntiHangover.new(64, 8) }
      its(:permissible_alcohol) { should == 96 }
    end

    context 'minus weight given' do
      specify do
        expect { @anti_hangover = AntiHangover.new(-1, 8) }.to raise_error ArgumentError
      end
    end

    context 'minus hours given' do
      specify do
        expect { @anti_hangover = AntiHangover.new(64, -1) }.to raise_error ArgumentError
      end
    end
  end

  # 飲む : 種類と数を渡して今まで飲んだ数を返す
  describe '#drink' do
    before do
      @anti_hangover = AntiHangover.new(75, 8)
    end

    context 'drink first beer' do
      subject { @anti_hangover.drink :beer }
      it { should == 1 }
    end

    context 'drink second beer' do
      before { @anti_hangover.drink :beer }
      subject { @anti_hangover.drink :beer }
      it { should == 2 }
    end

    context 'drunk 3 sake' do
      subject { @anti_hangover.drink :sake, 3 }
      it { should == 3 }
    end

    context 'drunk unknown alcohol' do
      specify do
        expect { @anti_hangover.drink :unknwon_alcohol }.to raise_error ArgumentError
      end
    end
  end

  # 現在までに飲んだアルコールの総量を返す (ml)
  describe '#total_drunk' do
    before do
      @anti_hangover = AntiHangover.new(75, 8)
    end

    context 'drunk beer, beer, sake, wine' do
      before do
        @anti_hangover.drink :beer, 2
        @anti_hangover.drink :sake
        @anti_hangover.drink :wine
      end
      subject { @anti_hangover.total_drunk }
      it { should == 35 + 22 + 18 }
    end
  end

  # 二日酔いするかどうかを返す
  describe '#hangover?' do
    before do
      @anti_hangover = AntiHangover.new(64, 8)
    end
    context 'without drinking' do
      subject { @anti_hangover.hangover? }
      it { should be_false }
    end
    context 'too much drinking' do
      before do
        @anti_hangover.drink :beer        # 17.5
        @anti_hangover.drink :chuhi       # 14.0
        @anti_hangover.drink :sake        # 21.6
        @anti_hangover.drink :wine        # 18.0
        @anti_hangover.drink :shochu      # 15.0
        @anti_hangover.drink :whiskey     # 16.0
      end
      subject { @anti_hangover.hangover? }
      it { should be_true }
    end
  end

  describe '#dump' do
    before do
      @anti_hangover = AntiHangover.new(64, 8)
    end

    context 'without drinking' do
      subject { r = @anti_hangover.dump ; puts r ; r }
      it { should be_instance_of String }
    end

    context 'after too much drinking' do
      before do
        @anti_hangover.drink :beer,     0 # 17.5
        @anti_hangover.drink :chuhi,    2 # 14.0
        @anti_hangover.drink :sake        # 21.6
        @anti_hangover.drink :wine,     3 # 18.0
        @anti_hangover.drink :shochu,  12 # 15.0
        @anti_hangover.drink :whiskey,  1 # 16.0
      end
      subject { r = @anti_hangover.dump ; puts r ; r }
      it { should be_instance_of String }
    end
  end
end
