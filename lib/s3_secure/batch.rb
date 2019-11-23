module S3Secure
  class Batch
    extend Memoist

    def initialize(*params)
      @params = params
      @command, @subcommand, @file = params
    end

    def run
      buckets.each do |bucket|
        args = @params
        args.pop
        args << bucket
        puts "Running: s3-secure #{args.join(' ')}".color(:green)
        S3Secure::CLI.start(args)
      end
    end

    def buckets
      IO.readlines(@file).map(&:strip).reject(&:empty?)
    end
    memoize :buckets
  end
end