require "text-table"

module S3Secure
  class Table
    attr_reader :data
    def initialize(options, data)
      @options = options
      @data = data
    end

    def display
      table = Text::Table.new
      table.head = data.shift
      table.rows = data
      puts table
    end
  end
end
