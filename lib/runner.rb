module Runner

  def self.run(day: nil, part: nil)
    to_run = []
    if day.nil?
      days.each do |d, parts|
        parts.each do |p|
          run_part_with_ouput d, p
        end
      end
    else
      if part.nil?
        pp day
        days[day].each do |p|
          run_part_with_ouput day, p
        end
      else
        run_part_with_ouput day, part
      end
    end
  end

  def self.run_part(day, part)
    part_module = Kernel.const_get("Day#{day}").const_get("Part#{part}")
    output = part_module.run(File.read("input/day_#{day}.txt").strip)
  end

  private

  def self.run_part_with_ouput(day, part)
    puts "\e[34mRunning day #{day} part #{part}:\e[0m"
    output = run_part(day, part)
    puts "\e[36m  Output: #{output}\e[0m"
  end

  def self.days
    Dir.glob('lib/day_*').map do |d|
      day_number = d.to_s.gsub('lib/day_', '').to_i
      parts = Dir.glob("lib/day_#{day_number}/part_*.rb").map do |p|
        p.match(/lib\/day_#{day_number}\/part_(\d+).rb/).captures[0].to_i
      end
      parts.sort!
      [day_number, parts]
    end.to_h
  end

end
