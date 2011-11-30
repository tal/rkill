module Rkill
  BIN = "/bin/kill"
  SIGNALS = `#{BIN} -l`.chomp.split(' ')
  class CLI

    def initialize opts
      @opts = opts.dup.freeze
      detect_type
    end

    def detect_type
      indexes = []
      indexes << @regex_index = @opts.find_index {|opt| opt =~ /^\/.+\/[imx]{0,3}$/}
      indexes << @pcpu_index = @opts.find_index {|opt| opt =~ /^pcpu$/i}
      indexes << @pmem_index = @opts.find_index {|opt| opt =~ /^pmem$/i}
      indexes << @mem_index = @opts.find_index {|opt| opt =~ /^mem$/i}
      @first_index = indexes.compact.min
    end

    def get_processes
      return if @first_index.nil?
      pcpu = eval(@opts[@pcpu_index+1]) if @pcpu_index
      
      pmem = eval(@opts[@pmem_index+1]) if @pmem_index

      mem  = eval(@opts[@mem_index+1]) if @mem_index

      regex = eval(@opts[@regex_index]) if @regex_index

      processes = regex.nil? ? PS.all : PS(regex)

      processes = processes.over :pcpu, pcpu if pcpu
      processes = processes.over :pmem, pmem if pmem
      processes = processes.over :mem,  mem  if mem

      processes
    end

    def run!
      command = BIN.dup << ' '
      
      if @first_index.nil?
        command << "'#{ARGV.join("' '")}'"
      else
        command << "'" << ARGV[0...@first_index].join("' '") << "' "
        procs = get_processes.choose("Select processes to kill or hit enter to select all:")
        pids = procs.collect {|proc| proc.pid if proc}.compact

        abort if pids.empty?

        command << pids.join(' ')
      end

      if Rkill.test
        puts command
      else
        system(command)
      end
    end

    class << self
      def start
        new(ARGV).run!
      end
    end

  end
end
