# frozen_string_literal: true

Sequel.seed(:development) do
  def run
    puts 'Seeding accounts, links, files'
    create_accounts
    create_owned_links
    create_files
    add_accessors
  end
end

require 'yaml'
DIR = File.dirname(__FILE__)
ACCOUNTS_INFO = YAML.load_file("#{DIR}/accounts_seed.yml")
OWNER_INFO = YAML.load_file("#{DIR}/owners_links.yml")
LINK_INFO = YAML.load_file("#{DIR}/links_seed.yml")
FILE_INFO = YAML.load_file("#{DIR}/files_seed.yml")
ACCESSOR_INFO = YAML.load_file("#{DIR}/links_accessors.yml")

def create_accounts
  ACCOUNTS_INFO.each do |account_info|
    EtaShare::Account.create(account_info)
  end
end

def create_owned_links
  OWNER_INFO.each do |sender|
    account = EtaShare::Account.first(username: sender['username'])
    sender['link_title'].each do |link_title|
      link_data = LINK_INFO.find { |link| link['title'] == link_title }
      EtaShare::CreateLinkForOwner.call(
        owner_id: account.id, link_data:
      )
    end
  end
end

def create_files
  file_info_each = FILE_INFO.each
  links_cycle = EtaShare::Link.all.cycle
  loop do
    file_info = file_info_each.next
    link = links_cycle.next
    EtaShare::CreateFile.call(
      account: link.owner, link:, file_data: file_info
    )
  end
end

def add_accessors
  access_info = ACCESSOR_INFO
  access_info.each do |access|
    link = EtaShare::Link.first(title: access['link_title'])
    access['accessor_email'].each do |email|
      account = link.owner
      EtaShare::AddAccessor.call(
        account:, link:, accessor_email: email
      )
    end
  end
end
