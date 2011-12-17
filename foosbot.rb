# encoding: utf-8
require 'cinch'
require 'cleverbot'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.jlatt.com"
    c.port = 6697
    c.nick = 'foosbot'
    c.password = 'smellyoulater'
    c.ssl = true
    #c.channels = ["#foosbot-test"]
    c.channels = ["#verticalbrands foosball", "#foosbot-test"]

    @game = false
    @players = []
    @blacklist = ['foosbot', 'matt', 'matt_', 'Kyle', 'Kyle_']
    @cleverbot = Cleverbot::Client.new
  end

  on :message, "!foos" do |m|

    if not @game
      #if Random.new.rand(0..6) == 0
      #  m.reply "I'm sorry Dave, I'm afriad I can't do that." if Random.new.rand(0..3) == 0
      #  return nil
      #end
      m.reply "#{m.user.nick} wants to start a game, who's in? Type !foos to join."
      players = m.channel.users.keys.map(&:nick) - @blacklist
      m.reply "#{players.join(', ')} ^"
      @game = true
      @players << m.user.nick
    else
      m.reply "#{m.user.nick} joined the game."
      @players << m.user.nick
      if @players.count < 4
        m.reply "#{4 - @players.count} players still needed.  Current players: #{@players.join(', ')}"
      else
        m.reply "game ready: #{@players.join(', ')}"
        @players = []
        @game = false
        case Random.new.rand(0..6)
        when 0 then m.reply "kthxbye"
        when 1 then m.reply "Hiyooooo!"
        when 2 then m.reply "I'm a personality prototype, you can tell can't you?"
        when 3 then m.reply "Life? Don't talk to me about life."
        when 4 then m.reply "I'd make a suggestion, but you wouldn't listen.  No one ever does."
        when 5 then m.reply "I've calculated your chance of survival, but i don't think you'll like it."
        when 6 then m.reply "This will all end in tears."
        end
      end
    end
  end

  on :message, "!cancel" do |m|
    if @game
      @game = false
      @players = []
      m.reply "game cancelled."
    else
      m.reply "no game started."
    end
  end

  on :message, "!status" do |m|
    if @game
      m.reply "#{4 - @players.count} players still needed.  Current players: #{@players.join(', ')}"
    else
      m.reply "no game started."
    end
  end

  on :message, "!help" do |m|
    m.reply "!foos - start or join a game\n!status - check status of current game\n!cancel - cancel current game\n!flip - desk flip\n!help - helpception"
  end

  on :message, /\ rod/ do |m|
    m.reply "That's what she said lol" if Random.new.rand(0..3) == 0
  end

  on :message, /nope/ do |m|
    m.reply "chuck testa" if Random.new.rand(0..3) == 0
  end

  on :message, /banana/ do |m|
    case Random.new.rand(0..6)
    when 0 then m.reply "Hiyooooo!"
    when 1 then m.reply "stfu"
    else m.reply "Hilarious!"
    end
  end

  on :message, /confused/ do |m|
    m.reply "#{m.user.nick}, con-foos-ed?" if Random.new.rand(0..3) == 0
  end

  on :message, /pizza/ do |m|
    m.reply "#{m.user.nick}, are you a vegetarian?" if Random.new.rand(0..1) == 0
  end

  on :message, /jitterbit/ do |m|
    m.reply "*snap* *snap*" if Random.new(0..1) == 0
  end

  on :message, /\ dump\ / do |m|
    m.reply "tee hee hee" if Random.new.rand(0..2) == 0
  end

  on :message, /[K|k]obs|[H|h]erndon/ do |m|
    case Random.new.rand(0..2)
    when 0 then m.reply "monkey suit?"
    when 1 then m.reply "business, lol"
    when 2 then m.reply "keep that guy away from playgrounds and schools... "
    end
  end

  on :message, /foosbot/ do |m|
    params = m.reply @cleverbot.write m.message
  end

  on :message, /nyan/ do |m|
    m.reply "-_-_-_-_-_-_-_,------,
_-_-_-_-_-_-_-|   /\\_/\\
-_-_-_-_-_-_-~|__( ^ .^)
_-_-_-_-_-_-_-\"\"  \"\"      "
  end

  on :message, "!flip" do |m|
    m.reply "（╯°□°）╯︵ ┻━┻"
  end

  on :message, "!unflip" do |m|
    m.reply "┬─┬ ﻿ノ( ゜-゜ノ)"
  end

  on :message, "!sup" do |m|
    m.reply "¯\_(ツ)_/¯"
  end

  on :message, /desk\ flip|deskflip|flip\ a\ desk/ do |m|
    m.reply "（╯°□°）╯︵ ┻━┻"
  end

  on :message, /why/ do |m|
    m.reply "42" if Random.new.rand(0..2) == 0
  end
end

bot.start
