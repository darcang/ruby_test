module Agile
  class SystemDependencies
    def initialize(input_file)
      @parsed_file = parse_file(File.new(input_file))
    end

    def perform
      parsed_file.map do |line|
        process_the_line(line)
      end
    end

    private

      attr_reader :parsed_file

      def parse_file(sample_file)
        sample_file.readlines
      end

      def process_the_line(line)
        puts line
        args = line.split
        command = args.shift
        args = args.first if args.size == 1
        Agile::Commands.public_send(command.downcase, args)
      end
  end
end
