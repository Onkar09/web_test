# -*- encoding: utf-8 -*-
# stub: webshot 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "webshot".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vitalie Cherpec".freeze]
  s.date = "2017-01-06"
  s.description = "Captures a web page as a screenshot using Poltergeist, Capybara and PhantomJS".freeze
  s.email = ["vitalie@penguin.ro".freeze]
  s.homepage = "https://github.com/vitalie/webshot".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.9".freeze
  s.summary = "Captures a web page as a screenshot".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<gem-release>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<poltergeist>.freeze, ["~> 1.12.0"])
      s.add_runtime_dependency(%q<faye-websocket>.freeze, ["~> 0.7.3"])
      s.add_runtime_dependency(%q<mini_magick>.freeze, ["~> 4.3.3"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<gem-release>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<poltergeist>.freeze, ["~> 1.12.0"])
      s.add_dependency(%q<faye-websocket>.freeze, ["~> 0.7.3"])
      s.add_dependency(%q<mini_magick>.freeze, ["~> 4.3.3"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<gem-release>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<poltergeist>.freeze, ["~> 1.12.0"])
    s.add_dependency(%q<faye-websocket>.freeze, ["~> 0.7.3"])
    s.add_dependency(%q<mini_magick>.freeze, ["~> 4.3.3"])
  end
end
