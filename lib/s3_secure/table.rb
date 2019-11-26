require "text-table"

module S3Secure
  class Table
    def initialize(options, data)
      @options = options
      @data = data
    end

    def data
      @options[:header] ? @data : @data[1..-1]  # remove the header row
    end

    def display
      table = Text::Table.new
      table.head = data.shift
      table.rows = data
      puts table
    end
  end
end
