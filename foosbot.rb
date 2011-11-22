require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.jlatt.com"
    c.port = 6697
    c.nick = 'foosbot'
    c.password = 'smellyoulater'
    c.ssl = true
    c.channels = ["#verticalbrands foosball", "#foosbot-test"]

    @game = false
    @players = []
    @blacklist = ['foosbot', 'matt', 'matt_', 'Kyle', 'Kyle_']
  end

  on :message, "!foos" do |m|
    if not @game
      m.reply "#{m.user.nick} wants to start a game, who's in? Type !foos to join."
      players = m.channel.users.keys.map(&:nick) - @blacklist
      m.reply "#{players.join(', ')} ^"
      @game = true
      @players << m.user.nick
    else
      m.reply "#{m.user.nick} joined the game."
      @players << m.user.nick
      if @players.count < 4
        m.reply "#{4 - @players.count} players still needed."
      else
        m.reply "game ready: #{@players.join(', ')}"
        @players = []
        @game = false
        m.reply "kthxbye" if Random.new.rand(0..4) == 0
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

  on :message, /\ rod/ do |m|
    m.reply "That's what she said lol" if Random.new.rand(0..3) == 0
  end

  on :message, /nope/ do |m|
    m.reply "chuck testa" if Random.new.rand(0..3) == 0
  end

  on :message, /yes|always|never|definitely/ do |m|
    m.reply "well that's just like, you're opinion man" if Random.new.rand(0..2) == 0
  end

  on :message, /[Y|y]eah/ do |m|
    m.reply "well that's just like, your opinion man" if Random.new.rand(0..5) == 0
  end

  on :message, /banana/ do |m|
    m.reply "hillarious!"
  end

  on :message, /confused/ do |m|
    m.reply "#{m.user.nick}, con-foos-ed?" if Random.new.rand(0..3) == 0
  end

  on :message, /pizza/ do |m|
    m.reply "#{m.user.nick}, are you a vegetarian?" if Random.new.rand(0..1) == 0
  end

  on :message, /jitterbit/ do |m|
    m.reply "*snap* *snap*"
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

end

bot.start
