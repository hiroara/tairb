require 'tailrb/version'
require 'json'

class Tailrb

  def initialize path
    @path = File.expand_path path
  end

  def run config={}
    config = Configuration.new self, config

    self.send config.tailf_method, config.bytes, config.filter, &config.script
  end

  def tailf bytes=10000, filter=nil
    seeked_file(bytes) do |file|
      buf = ''
      loop do
        next unless str = file.read_nonblock(10) rescue !sleep(0.1)
        next print str unless block_given?
        buf += str
        lines = buf.split /\r\n?|\n/, -1
        while line = lines.shift
          break buf = line if lines.empty?
          next if filter && !filter.call(line)
          yield line
        end
      end
    end
  rescue Interrupt
    # exit
  end

  def tailf_tsv bytes=10000, filter=nil
    tailf(bytes) do |line|
      line.split("\t").inject({}) do |memo, token|
        key, val = token.split(':', 2)
        memo[key.intern] = val
        memo
      end.tap do |dat|
        next if filter && !filter.call(dat)
        block_given? ? yield(dat) : puts(to_tsv(dat))
      end
    end
  end

  private
  def seeked_file bytes, &block
    open(@path, 'r') do |file|
      raise "Not supported file type: #{file.stat.ftype}." unless file.stat.ftype == 'file'
      file.seek(file.stat.size.tap { |size| break size > bytes ? size - bytes : 0 })
      block.call file
    end
  end

  def to_s line
    line.to_s
  end
  def to_tsv dat
    dat.map{ |k, v| "#{k}:#{v}" }.join("\t")
  end
end

require 'tailrb/configuration'
