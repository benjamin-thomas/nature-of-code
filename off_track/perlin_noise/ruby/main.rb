=begin

$ rm /tmp/rb-white-noise.ppm ; time ruby ./main.rb && eog /tmp/rb-white-noise.ppm

real    0m0.441s
user    0m0.410s
sys     0m0.029s

=end

require 'fileutils'

Dimension = Struct.new(:width, :height)
Color = Struct.new(:r, :g, :b)

class Noise
  MAX_VALUE = 0xFF
  MAGIC_NUMBER = 'P6'

  def initialize(filepath, dim, colors)
    @filepath = filepath
    @dim = dim
    @colors = colors
  end

  def generate!
    File.open(@filepath, 'wb') do |file|
      write_ppm_data(file)
    end
  end

  private

  def write_ppm_data(file)
    line = <<~EOS
      #{MAGIC_NUMBER}
      #{@dim.width} #{@dim.height}
      #{MAX_VALUE}
    EOS

    file.write(line)

    @dim.width.times do
      @dim.height.times do
        rand_idx = rand(@colors.length)
        write_color(file, @colors[rand_idx])
      end
    end
  end

  def write_color(file, col)
    rgb = [
      (col.r * MAX_VALUE).floor,
      (col.g * MAX_VALUE).floor,
      (col.b * MAX_VALUE).floor,
    ]
    bytes = rgb.pack('C*')
    file.write(bytes)
  end
end

def run
  dim = Dimension.new(512, 512)
  colors = [
    Color.new(0.4078, 0.4078, 0.3764), # [103, 103,  95] / [0x67, 0x67, 0x5F]
    Color.new(0.7606, 0.6274, 0.6313), # [193, 159, 160] / [0xC1, 0x9F, 0xA0]
    Color.new(0.8980, 0.9372, 0.9725), # [228, 238, 247] / [0xE4, 0xEE, 0xF7]
  ]
  filepath = '/tmp/rb-white-noise.ppm'

  noise = Noise.new(filepath, dim, colors)
  noise.generate!

  puts "Pattern generated at: #{filepath}"
end

run