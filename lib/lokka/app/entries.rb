module Lokka
  class App
    # index
    get '/' do
      @theme_types << :index
      @theme_types << :entries
      render_detect :index, :entries
    end

    get '/index.atom' do
      redirect to('http://blog.willnet.in/feed')
    end

    # entry
    get %r{^/([_/0-9a-zA-Z-]+)$} do |id_or_slug|
      @entry = Entry.get_by_fuzzy_slug(id_or_slug)

      return 404 if @entry.blank?
      redirect to("http://blog.willnet.in/entry/#{@entry.created_at.strftime('%Y/%m/%d/%H%M%S')}", 301)
    end
  end
end
