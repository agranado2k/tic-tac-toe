class GameIOSub < CommandLineGames::GameIO
  attr_accessor :input
  attr_reader :content

  def initialize
    @content = ''
  end

  def waiting_for_input
    input
  end

  def output(content)
    @content += "#{content}"
  end
end