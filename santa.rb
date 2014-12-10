#!/usr/bin/env ruby

# Secret Santa - a tool to randomly select Christmas gifts from eBay.
# Copyright (C) 2012 "Duncan Bayne" <dhgbayne@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

require 'rubygems'
require 'nokogiri'
require 'rest_client'

# URLs of all categories we're interested in
load 'categories.rb'

# $4 - 5; Buy Now; Free Postage; Australia Only
SEARCH_OPTIONS = 'LH_FS=1&_udlo=9&LH_BIN=1&_mPrRngCbx=1&_udhi=10&LH_PrefLoc=1&_arr=1'

# number of presents to open
PRESENTS = 3

# browser executable to use
BROWSER = 'firefox'

def get_category_document category
  page = RestClient.get "#{category}?#{SEARCH_OPTIONS}"
  Nokogiri::HTML::parse page
end

def get_first_filtered_item_in category
  category_doc = get_category_document category
  remove_overseas_nodes category_doc
  link = first_item_link category_doc
  if link
    link.attr('href')
  else
    $stderr.puts "santa.rb: found no matching items in #{category}"
    nil
  end
end

def remove_overseas_nodes doc
  doc.xpath('//div[@class="tp"]').each do |node|
    node.remove
    $stderr.puts "santa.rb: removed overseas sellers from page"
  end
end

def first_item_link category_doc
  item_link = category_doc.xpath('//a[starts-with(@class, "vip")]').first
end

def random_item_url
  category = CATEGORIES[rand(CATEGORIES.length)]
  get_first_filtered_item_in category
end

found = 0
until (found == PRESENTS) do
  item_url = random_item_url
  if item_url
    found = found + 1
    system "#{BROWSER} #{item_url}"
  end
end
