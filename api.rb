require 'json'

module API
  def def_level(&blk)
    res = {"type" => "root"}
    if respond_to?(:[]=)
      self["subsections"] ||= []
      self["subsections"] << res
    end
    res.instance_eval(&blk)
    res["subsections"].each do |subsec|
      id = subsec["id"]
      if !id && subsec["name"]
        id = subsec["name"].downcase.gsub(/[^A-Za-z0-9]/, '_')
      end

      node = subsec["node"]
      if !node && subsec["name"]
        node = subsec["name"].gsub(/[^A-Za-z0-9 ]/, '').split(' ').map(&:capitalize).join
      end

      puts "[#{id}]"
      puts "type=#{subsec.fetch("type").to_json}"
      unless id == "_intro"
        puts "name=#{subsec.fetch("name").to_json}"
        puts "node=#{node.to_json}"
      end
      subsec.delete("id")
      subsec.delete("type")
      subsec.delete("name")
      subsections = subsec.delete("subsections")
      subsec.each do |k, v|
        puts "#{k}=#{v.to_json}"
      end
      if subsections
        puts "subsections=#{JSON.pretty_generate(subsections)}"
      end
      puts
    end
  end

  %i(
    sequence
    camera_zoom
    simple
    choice
    password
    sticky_note
    multi_visit
    calendar
    search_engine
  ).each do |sym|
    class_eval <<~EOF
      def #{sym}(&blk)
        res = {"type" => "#{sym}"}
        if respond_to?(:[]=)
          self["subsections"] ||= []
          self["subsections"] << res
        end
        res.instance_eval(&blk)
        res
      end
    EOF
  end

  alias choose choice

  def message(msg)
    simple do |s|
      s.message = msg
    end
  end

  def messages(msgs)
    simple do |s|
      s.messages = msgs
    end
  end

  def on_choice(choice_msg, &blk)
    self["choices"] ||= []
    self["choices"] << choice_msg
    instance_eval(&blk)
  end
end

class Hash
  include API

  def method_missing(sym, *args)
    if sym.end_with?("=")
      sym_s = sym.to_s[0..-2]
      self[sym_s] = args[0]
    else
      super
    end
  end
end
