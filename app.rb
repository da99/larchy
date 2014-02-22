

require 'sinatra'

set :port, 5555
set :public_folder, './public'


def get_entries path
  full = File.join('public', path)
  Dir.entries(full).sort.map { |l|
    next if ['.'].include?(l) || l[/^\.[^\.]/]
    url = l.sub('public', '')
    url = File.join(url, '/') if File.directory?(File.join(full, l))
    %~ <a href="#{File.join path, url}">#{url}</a> ~
  }.compact.join("<br />")
end

get "/*" do
  pass if request.path['favicon.ico']
  local_dir = File.join('public/', request.path)
  local_index = File.join(local_dir, 'index.html')
  if File.file?(local_index)
    redirect to(File.join(request.path, 'index.html'))
  else
    "<p>#{request.path}</p>" +
      get_entries(request.path)
  end
end



