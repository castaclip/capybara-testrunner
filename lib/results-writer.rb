require 'rexml/document'

module ResultsWriter

  def self.write(doc, out)
    if doc.nil? then
      return
    end
    
    pretty_formatter = REXML::Formatters::Pretty.new(2)
    pretty_formatter.compact = true
    pretty_formatter.write(doc, out)
  end
  
end
