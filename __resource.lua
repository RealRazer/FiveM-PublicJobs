resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.2.0'

client_scripts {
  '@es_extended/locale.lua',
  'config.lua',
  'client/main.lua',
  'client/main2.lua',
  'client/selleverything.lua',
}

server_scripts {
  '@es_extended/locale.lua',
  'config.lua',
  'server/main.lua'
}

ui_page "html/razer.html"


files {
  'img/*.png',
  'html/debounce.min.js',
  'html/iransans.otf',
  'html/razer.html',
  'html/razer.js',
  'html/razer.css'
}