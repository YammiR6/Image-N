require 'models/example'
require 'chunky_png'

set :bind, '0.0.0.0'

class Challenge < Sinatra::Base
  get '/challenge' do
    what_to_hello = Example.new("World!")   
    content_type :json
    status 200
    headers ({})
    body ({ hello: what_to_hello.to_s }.merge(params).to_json)
  end

  post '/fontChange' do
    begin
      body =  JSON.parse(request.body.read)
      data = Base64.decode64(body['encoded'])
      png = ChunkyPNG::Image.from_string(data)

      png.pixels.each_index do |i|
        x = i % png.width
        y = i / png.width
        if png.pixels[i] == 255
          png.pixels[i] = 0xff0000ff
        end
      end

      File.open('fontChange.txt', 'w') do |f|
        f.write(Base64.encode64(png.to_string))
      end

      status 200
      content_type :json
      headers ({})
      body ({ encoded: Base64.encode64(png.to_string) }.to_json)
    rescue => e
      puts e
    end
  end

  post '/inverse' do
    begin
      body =  JSON.parse(request.body.read)
      data = Base64.decode64(body['encoded'])
      png = ChunkyPNG::Image.from_string(data)

      png.pixels.each_index do |i|
        color = png.pixels[i] >> 8
        png.pixels[i] = ((0xffffff - color) << 8) | 255
      end

      File.open('inverse.txt', 'w') do |f|
        f.write(Base64.encode64(png.to_string))
      end

      status 200
      content_type :json
      headers ({})
      body ({ encoded: Base64.encode64(png.to_string) }.to_json)
    rescue => e
      puts e
    end
  end

  post '/rotate' do
    begin
      body =  JSON.parse(request.body.read)
      data = Base64.decode64(body['encoded'])
      png = ChunkyPNG::Image.from_string(data)
      new_png = ChunkyPNG::Image.new(png.height, png.width)

      png.pixels.each_index do |i|
        x = i % png.width
        y = i / png.width
        new_png.set_pixel((png.height - y), x, png.pixels[i])
      end

      File.open('rotate.txt', 'w') do |f|
        f.write(Base64.encode64(new_png.to_string))
      end

      status 200
      content_type :json
      headers ({})
      body ({ encoded: Base64.encode64(new_png.to_string) }.to_json)
    rescue => e
      puts e
    end
  end

end
