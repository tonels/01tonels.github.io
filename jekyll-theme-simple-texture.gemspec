# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-simple-texture"
  spec.version       = "0.4.0"
  spec.authors       = ["Tonels"]
  spec.email         = ["liangshuai0012018@outlook.com"]

  spec.summary       = %q{A gem-based responsive  styled Jekyll theme.}
  spec.homepage      = "https://github.com/tonels/tonels.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|_layouts|_includes|_sass|LICENSE|README)}i) }

  spec.add_runtime_dependency "github-pages", '~> 188'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
