module FlashesHelper

  FLASSCLASS = {:notice => "success", :alert => "danger", :warning => "warning"}.freeze

  def flash_class(key)
      return  FLASSCLASS.fetch key.to_sym, key
  end

  def flash_using_message(flashmsgs)
     return flashmsgs.to_hash.slice("alert", "warning", "notice")
  end
end
