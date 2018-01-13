module Agile
  class SystemDependencies
    def initialize(input_file)
      @input_file = parse_file File.new(input_file)
    end

    def perform
      input_file.map do |line|
        puts line
        args_array = line.split
        command = args_array.shift
        args = args_array.first if args_array.size == 1
        Agile::Commands.public_send(command.downcase, args)
      end
    end

    private

      attr_reader :input_file

      def parse_file(sample_file)
        sample_file.readlines
      end
  end
end