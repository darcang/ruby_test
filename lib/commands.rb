module Agile
  class Commands
    class << self
      def depend(args)
        default_dependencies[args.shift] = args
      end

      def install(program)
        if installed?(program)
          puts "    #{program} is already installed."
        else
          install_dependent_programs(program)
          install_program(program)
        end
      end

      def remove(program)
        case
        when !installed?(program)
          puts "    #{program} is not installed."
        when removable?(program)
          remove_program(program)
          remove_dependent_programs(program)
        else
          puts "    #{program} is still needed."
        end
      end

      def list(args = nil)
        output = installed_programs.join("\n    ")
        puts "    #{output}"
      end

      def end(args = nil)
        abort
      end

      private

        attr_reader :default_dependencies, :installed_programs

        def install_program(program)
          puts "    Installing #{program}"
          installed_programs << program
        end

        def remove_program(program)
          puts "    Removing #{program}"
          installed_programs.delete(program)
        end

        def install_dependent_programs(program)
          programs_to_install = default_dependencies[program]
          return unless programs_to_install

          programs_to_install.each do |program|
            install_program(program) unless installed?(program)
          end
        end

        def remove_dependent_programs(program)
          programs_to_remove = default_dependencies[program]
          return unless programs_to_remove

          programs_to_remove.each do |dependent_program|
            remove_program(dependent_program) if removable?(dependent_program)
          end
        end

        def installed?(program)
          installed_programs.include?(program)
        end

        def removable?(program)
          !actual_dependencies.values.flatten.include?(program)
        end

        def actual_dependencies
          default_dependencies.reject { |dep| !installed_programs.include?(dep) }
        end

        def default_dependencies
          @default_dependencies ||= Hash.new
        end

        def installed_programs
          @installed_programs ||= []
        end
    end
  end
end