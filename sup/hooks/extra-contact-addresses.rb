#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'xapian'
require 'trollop'
require 'set'

unless defined? BASE_DIR
  BASE_DIR = ENV["SUP_BASE"] || File.join(ENV["HOME"], ".sup")
end

xapian = Xapian::Database.new File.join(BASE_DIR, 'xapian')
version = xapian.get_metadata 'rescue-version'
version = '0' if version.empty?

contacts = Hash.new { |key| Set.new }

case version
when '0'
  xapian.postlist('Kmail').each do |x|
    entry = Marshal.load(xapian.document(x.docid).data)
    ([entry[:from]] + entry[:to] + entry[:cc] + entry[:bcc]).compact.each do |email, name|
      next if email.nil?
      name = name.strip.chomp("'").chomp('"').reverse
                       .chomp("'").chomp('"').reverse unless name.nil?
      email.downcase!
      if name.nil? or email.include? name.downcase
        contacts[email] = Set.new unless contacts.has_key? email
      else
        contacts[email] <<= name
      end
    end
  end
else
  abort "this sup-dump version doesn't understand your index"
end

contacts.map do |email, names|
  if names.empty?
    email
  else
    names.map { |name| "#{name} <#{email}>" }
  end
end.flatten

