#!/usr/bin/env ruby
if ARGV.include?('--help')
	File.read(__FILE__).split("\n").grep(/^# /).each do |line|
		puts line[2..-1]
	end
	exit 0
end

root = File.expand_path('../../', __FILE__)
$:.unshift File.expand_path('lib', root)

require 'redcarpet'
require 'pygments'

class HTMLwithPygments < Redcarpet::Render::HTML
	def block_code(code, language)
		Pygments.highlight(code, :lexer => language)
	end
end

render_extensions = {}
parse_extensions = {}
#renderer = Redcarpet::Render::HTML
renderer = HTMLwithPygments

ARGV.delete_if do |arg|
	if arg =~ /^--render-([\w-]+)$/
		arg = $1.gsub('-', '_')
		render_extensions[arg.to_sym] = true
	elsif arg =~ /^--parse-([\w-]+)$/
		arg = $1.gsub('-', '_')
		parse_extensions[arg.to_sym] = true
	elsif arg == '--smarty'
		renderer = Redcarpet::Render::SmartyHTML
	else
		false
	end
end

render = renderer.new(render_extensions)
STDOUT.write(Redcarpet::Markdown.new(render, parse_extensions).render(ARGF.read))
