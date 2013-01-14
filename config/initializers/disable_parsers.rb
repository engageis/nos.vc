# Solves Rails Security issues: CVE-2013-0156 and CVE-2013-0155
ActionDispatch::ParamsParser::DEFAULT_PARSERS.delete(Mime::XML)
ActiveSupport::XmlMini::PARSING.delete("symbol")
ActiveSupport::XmlMini::PARSING.delete("yaml")
