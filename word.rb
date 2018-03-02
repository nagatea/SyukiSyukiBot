#! /usr/bin/ruby
# coding: utf-8
require 'open-uri'
require 'nokogiri'
require 'natto'
Encoding.default_external = 'utf-8'

class Word
  def initialize(text = "すもももももももものうち")
    @wordlist = []
    @featurelist = []
    @text = text
    nm = Natto::MeCab.new
    nm.parse(@text) do |n|
      @wordlist.push(n.surface.to_s)
      @featurelist.push(n.feature.to_s)
    end
  end

  def get_word(form,int) #一番最初に出てくるint文字以上の〇詞を1つ取り出して返す
    len = @wordlist.length
    for i in 0..len-1 do
      if @featurelist[i].match(form.to_s) && @wordlist[i].to_s.length >= int.to_i
        return @wordlist[i]
      end
    end
    return "not"
  end

  def get_word_list(form,int) #すべてのint文字以上の〇詞を取り出してリストで返す
    word_list = []
    len = @wordlist.length
    for i in 0..len-1 do
      if @featurelist[i].match(form.to_s) && @wordlist[i].to_s.length >= int.to_i
        word_list.push(@wordlist[i])
      end
    end
    return word_list
  end

  def get_initial_wordlist
    return @wordlist
  end

  def get_initial_futurelist
    return @featurelist
  end

  def get_initial_list
    po = @wordlist.length
    popo = []
    for i in 0..po-1 do
      popo.push(@wordlist[i] + " : " + @featurelist[i])
    end
    return popo
  end

  def replace_words(array,form)
    len = @wordlist.length
    for i in 0..len-1 do
      if @featurelist[i].match(form.to_s)
        @wordlist[i] = array.shift unless array.empty?
      end
    end
    return @wordlist
  end
end


def array_to_s(array) #配列を全部くっつけて一つの文字列にする
  res = ""
  array.each do |youso|
    res = res + youso.to_s
  end
  return res
end