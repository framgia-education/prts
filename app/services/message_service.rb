class MessageService
  def initialize message
    @message = message
  end

  def customize_message_content
    @message.gsub! "[Reply", "[rp"
    @message.gsub! /\[Quote/, "[qt]\\0"
    @message.gsub! "[Quote", "[qtmeta"
    @message.gsub! "[/Quote]", "[/qt]"
  end
end
