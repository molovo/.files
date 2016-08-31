Maid.rules do
  rule 'Cleanup log files' do
    dir('/usr/local/var/log/**/*.log').each do |path|
      if 1.hour.since?(modified_at(path))
        remove(path)
        copy('/dev/null', path)
      end
    end
  end

  rule 'Remove old screenshots' do
    dir('~/Screenshots/*').each do |path|
      if 1.week.since?(accessed_at(path))
        trash(path)
      end
    end
  end

  rule 'Remove old files on Desktop' do
    dir('~/Desktop/*').each do |path|
      if 1.week.since?(accessed_at(path))
        trash(path)
      end
    end
  end

  rule 'Remove old Downloads' do
    dir('~/Downloads/*').each do |path|
      if 1.week.since?(accessed_at(path))
        trash(path)
      end
    end
  end
end
