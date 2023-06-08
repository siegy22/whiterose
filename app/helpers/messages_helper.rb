module MessagesHelper
  def message_classes(message)
    base = "w-full border-b border-black/10 dark:border-gray-900/50 text-gray-800 dark:text-gray-100 group "
    case
    when current_user == message.from
      base + "dark:bg-gray-800"
    when current_user == message.to && message.unread?
      base + "bg-blue-50 bg-gray-50 dark:bg-[#444654]"
    else
      base + "bg-gray-50 dark:bg-[#444654]"
    end
  end
end
